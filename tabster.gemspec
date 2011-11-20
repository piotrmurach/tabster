require File.expand_path('../lib/tabster/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'tabster'
  gem.authors       = [ "Piotr Murach" ]
  gem.email         = ""
  gem.homepage      = 'https://github.com/peter-murach/tabster'
  gem.summary       = %q{ Rails tabs generation library }
  gem.description   = %q{  }
  gem.version       = Tabster::VERSION::STRING.dup

  #gem.files = `git ls-files`.split("\n")
  gem.files = Dir['Rakefile', '{features,lib,spec}/**/*', 'README*', 'LICENSE*']
  gem.require_paths = %w[ lib ]

  gem.add_development_dependency 'rspec', '~> 2.4.0'
  gem.add_development_dependency 'cucumber', '>= 0'
  gem.add_development_dependency 'bundler', '~> 1.0.0'
  gem.add_development_dependency 'jeweler', '~> 1.6.4'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'guard-rspec'
end
