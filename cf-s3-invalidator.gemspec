Gem::Specification.new do |s|
  s.name          = 'cf-s3-invalidator'
  s.version       = '0.3.5'
  s.license       = 'MIT'
  s.summary       = 'A tool for invalidating AWS S3-based Cloudfront distributions'
  s.description   =
    'This lib fetches the names of all objects on an Amazon Web
    Services S3 bucket. Then it calls the Cloudfront invalidation REST API on the
    objects.

    The Cloudfront distribution must be based on the S3 bucket.'
  s.authors       = ['Lauri Lehmijoki']
  s.email         = 'lauri.lehmijoki@iki.fi'
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.executables   << 'cf-s3-inv'
  s.homepage      = 'https://github.com/laurilehmijoki/cf-s3-invalidator'

  s.add_dependency 'aws-sdk'
  s.add_dependency 'extensions'
  s.add_dependency 'colored', '= 1.2'

  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'aruba', '>= 0.4.7'
end
