require 'rubygems'
require 'openssl'
require 'digest/sha1'
require 'net/https'
require 'base64'
require 'colored'

module CloudfrontS3Invalidator
  class CloudfrontClient
    def initialize(aws_account, aws_secret, distribution)
      @aws_account = aws_account
      @aws_secret = aws_secret
      @distribution = distribution
    end

    def invalidate(items)
      items = to_cf_keys(items)
      body = %|
        <InvalidationBatch>
          <Paths>
            <Quantity>#{items.length}</Quantity>
            <Items>
              #{to_xml items}
            </Items>
          </Paths>
          <CallerReference>#{Time.now.utc.to_i}</CallerReference>
        </InvalidationBatch>
      |
      res = sign_and_call(
        "https://cloudfront.amazonaws.com/2012-05-05/distribution/#{@distribution}/invalidation",
        Net::HTTP::Post,
        body)
      print_invalidation_result(res, items)
    end

    def get_s3_bucket_name
      res = sign_and_call(
        "https://cloudfront.amazonaws.com/2012-05-05/distribution/#{@distribution}",
        Net::HTTP::Get)
      matches =
        res.body.scan(/<DomainName>([\w|\.]+)\.s3\.amazonaws\.com<\/DomainName>/)
      if matches.empty?
        nil
      else
        s3_bucket_name = matches.first.first
        s3_bucket_name
      end
    end

    private

    def sign_and_call(url, method, body = nil)
      date = Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")
      digest = Base64.encode64(
        OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), @aws_secret, date)).strip
      uri = URI.parse(url)
      req = method.new(uri.path)
      req.initialize_http_header({
        'x-amz-date' => date,
        'Content-Type' => 'text/xml',
        'Authorization' => "AWS %s:%s" % [@aws_account, digest]
      })
      req.body = body unless body == nil
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = http.request(req)
      if res.code.to_i.between? 200, 299
        res
      else
        raise "AWS API call failed. Reason:".red + "\n" + res.body
      end
    end

    def print_invalidation_result(http_response, items)
      puts "Invalidating Cloudfront items..."
      items.each do |item|
        puts "  #{item}".yellow
      end
      puts "succeeded".green
    end

    def to_cf_keys(s3_keys)
      s3_keys.map { |s3_key| "/#{s3_key}" }
    end

    def to_xml(items)
      items.map { |item| "<Path>#{item}</Path>" }
    end
  end
end
