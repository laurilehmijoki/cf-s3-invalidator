# Invalidator for AWS S3-based Cloudfront distributions

If your Amazon Web Services Cloudfront distribution is based on AWS S3, then
this library may be useful to you.

This library fetches all the object keys of a particular S3 bucket and then
calls on them the invalidation REST API of Cloudfront.

## Install

`gem install cf-s3-invalidator`

## Usage

You can specify the configuration as CLI parameters:

`cf-s3-inv --key <AWS-KEY> --secret <AWS-SECRET> --bucket <S3-BUCKET-NAME> --distribution <CLOUDFRONT-DISTRIBUTION-ID>`

Or you can store them into the file *_cf_s3_invalidator.yml*:

    s3_key: YOUR_AWS_S3_ACCESS_KEY_ID
    s3_secret: YOUR_AWS_S3_SECRET_ACCESS_KEY
    s3_bucket: your.bucket.com
    cloudfront_distribution_id: YOUR_CLOUDFRONT_DISTRIBUTION_ID

Then you can just run:

`cf-s3-inv`

## Development

[![Build Status](https://secure.travis-ci.org/laurilehmijoki/cf-s3-invalidator.png)]
(http://travis-ci.org/laurilehmijoki/cf-s3-invalidator)

Run Cucumber tests:

`bundle exec cucumber`

## License

MIT
