# -*- encoding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'mighty_associations/version'

Gem::Specification.new do |s|
  s.name = %q{mighty_associations}
  s.version = MightyAssociations::VERSION
  s.authors = ["Sergio Gil", "Luismi Cavallé", "Paco Guzmán"]
  s.homepage  = "https://github.com//mighty_associations"
  s.license = "MIT"
  s.email = %q{ballsbreaking@bebanjo.com}
  s.homepage = %q{http://github.com/bebanjo/mighty_associations}
  s.summary = %q{Traversing superpowers for your ActiveRecord associations}
  s.require_paths = ["lib"]

  s.files = [
    ".gitignore",
    "MIT-LICENSE",
    "README.rdoc",
    "Rakefile",
    "init.rb",
    "install.rb",
    "lib/mighty_associations.rb",
    "lib/mighty_associations/version.rb",
    "mighty_associations.gemspec",
    "test/mighty_associations_test.rb",
    "test/test_helper.rb",
    "uninstall.rb"
  ]
  s.test_files = [
    "test/mighty_associations_test.rb",
    "test/test_helper.rb"
  ]

  s.add_runtime_dependency 'activerecord', '>= 4.0.13', '< 5'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'minitest'
end
