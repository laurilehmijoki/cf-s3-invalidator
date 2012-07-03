require 'openssl'
require 'digest/sha1'
require 'net/https'
require 'base64'

# Adapted from:
# Confabulus @ http://blog.confabulus.com/2011/05/13/cloudfront-invalidation-from-ruby
class CloudfrontInvalidator
  def initialize(aws_account, aws_secret, distribution)
    @aws_account = aws_account
    @aws_secret = aws_secret
    @distribution = distribution
  end

  def invalidate(items)
    items = to_cf_keys(items)
    date = Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")
    digest = Base64.encode64(
      OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), @aws_secret, date)).strip
    uri = URI.parse(
      "https://cloudfront.amazonaws.com/2012-05-05/distribution/#{@distribution}/invalidation")
    req = Net::HTTP::Post.new(uri.path)
    req.initialize_http_header({
      'x-amz-date' => date,
      'Content-Type' => 'text/xml',
      'Authorization' => "AWS %s:%s" % [@aws_account, digest]
    })
    req.body = %|
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
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    res = http.request(req)
    print_operation_result(res, items)
  end

  def print_operation_result(http_response, items)
    success = http_response.code == '201'
    puts "Invalidating Cloudfront items"
    items.each do |item|
      puts "  #{item}"
    end
    if success
      puts "succeeded"
    else
      puts "FAILED, reason:"
      puts http_response.body
    end
  end

  def to_cf_keys(s3_keys)
    s3_keys.map { |s3_key| "/#{s3_key}" }
  end

  def to_xml(items)
    items.map{ |item| "<Path>#{item}</Path>" }
  end
end
