Feature: configuration file
  In order to easily specify AWS credentials and Cloudfront distribution name
  As a geek
  I want to use a configuration file

  Scenario: Missing key
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    s3_secret: YOUR_AWS_S3_SECRET_ACCESS_KEY
    cloudfront_distribution_id: CF_ID
    """
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    AWS key missing in the configuration file
    """

  Scenario: Missing secret
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    aws_key: AWS_KEY
    cloudfront_distribution_id: CF_ID
    """
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    AWS secret missing in the configuration file
    """

  Scenario: Missing Cloudfront distribution id
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    aws_key: AWS_KEY
    aws_secret: AWS_SECRET
    """
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    Cloudfront distribution id missing in the configuration file
    """

