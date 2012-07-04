Feature: cloudfront-s3-invalidator CLI help
  In order to use the invalidator
  As a geek
  I want to run cf-s3-inv and see instructions for using the software

  Scenario: Run cf-s3-inv without arguments and the configuration file
    When I run `cf-s3-inv`
    Then the output should contain:
    """
    Usage: cf-s3-inv [options]
    """
    And the output should contain:
    """
    ALTERNATIVELY, you can use a configuration file:
    """
