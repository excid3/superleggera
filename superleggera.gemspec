$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "superleggera/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "superleggera"
  s.version     = Superleggera::VERSION
  s.authors     = ["Chris Oliver"]
  s.email       = ["excid3@gmail.com"]
  s.homepage    = "https://github.com/excid3/superleggera"
  s.summary     = "PurgeCSS for Rails & Webpacker"
  s.description = "Monitor your CSS in development to create a whitelist for PurgeCSS in Rails with Webpacker"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
