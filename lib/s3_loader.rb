require 'rubygems'
require 'aws-sdk'

module CloudfrontS3Invalidator
  class S3Loader
    def initialize(key, secret)
      @s3 = AWS::S3.new(
        :access_key_id => key,
        :secret_access_key => secret)
    end

    def list_keys(bucket_name)
      s3_objects = []
      @s3.buckets[bucket_name].objects.each do |object|
        s3_objects << object.key
      end
      s3_objects
    end
  end
end
