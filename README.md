# Invalidator for AWS S3-based Cloudfront distributions

If your Amazon Web Services Cloudfront distribution is based on AWS S3, then
this library may be useful to you.

This library fetches all the object keys of a particular S3 bucket and then
calls on them the invalidation REST API of Cloudfront.

## Usage

`gem install cf-s3-invalidator`

`cf-s3-inv <AWS-KEY> <AWS-SECRET> <S3-BUCKET-NAME> <CLOUDFRONT-DISTRIBUTION-ID>`
