# Invalidator for AWS S3-based Cloudfront distributions

[![Build Status](https://secure.travis-ci.org/laurilehmijoki/cf-s3-invalidator.png)]
(http://travis-ci.org/laurilehmijoki/cf-s3-invalidator)

If your Amazon Web Services Cloudfront distribution is based on AWS S3, then
this library may be useful to you.

This library fetches all the object keys of a particular S3 bucket and then
calls on them the invalidation REST API of Cloudfront.

## Install

`gem install cf-s3-invalidator`

## Usage

You can specify the configuration as CLI parameters:

`cf-s3-inv --key <AWS-KEY> --secret <AWS-SECRET> --distribution <CLOUDFRONT-DISTRIBUTION-ID>`

Or you can store them into the file *_cf_s3_invalidator.yml*:

    aws_key: YOUR_AWS_ACCESS_KEY_ID
    aws_secret: YOUR_AWS_SECRET_ACCESS_KEY
    cloudfront_distribution_id: YOUR_CLOUDFRONT_DISTRIBUTION_ID

Then you can just run:

`cf-s3-inv`

## Development

Run tests:

`rake test`

## Troubleshooting

* Verify that the AWS user has CloudFront permissions. In the AWS web interface, this
  will be in the `permissions` section of 
  `https://console.aws.amazon.com/iam/home?region=REGION-CODE#users/USERNAME`

* If you're using cf-s3-invalidator from Travis CI, be sure the credentials are
  [encrypted](http://docs.travis-ci.com/user/encryption-keys/) with the correct key
  for the repository

## License

MIT
