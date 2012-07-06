Feature: cloudfront-s3-invalidator without AWS credentials

  In order to invalidate my S3-based Cloudfront distribution
  As a geek without AWS credentials
  I want to run cf-s3-inv and see that it tells me I have no valid credentials

  Scenario: Run cf-s3-inv with the configuration file that has invalid AWS access key
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    aws_key: YOUR_AWS_ACCESS_KEY_ID
    aws_secret: YOUR_AWS_SECRET_ACCESS_KEY
    cloudfront_distribution_id: CF_ID
    """
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    The security token included in the request is invalid
    """

  Scenario: Run cf-s3-inv with the configuration file that has invalid S3 access key
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    s3_key: YOUR_AWS_S3_ACCESS_KEY_ID
    s3_secret: YOUR_AWS_S3_SECRET_ACCESS_KEY
    cloudfront_distribution_id: CF_ID
    """
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    The security token included in the request is invalid
    """

  Scenario: Run cf-s3-inv with CLI arguments containing invalid AWS access key
    When I run `cf-s3-inv --key invalidawskey --secret invalidawssecret --distribution some-dist`
    Then the output should contain:
    """
    The security token included in the request is invalid
    """
