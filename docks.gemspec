require "rubygems"

# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'docks/version'

Gem::Specification.new do |s|
  s.name                = 'docks'
  s.version             = Docks::VERSION
  s.platform            = Gem::Platform::RUBY
  s.authors             = ['Chris Sauve']
  s.email               = ['chrismsauve@gmail.com']
  s.license             = 'MIT'
  s.homepage            = ''
  s.summary             = 'A documentation and styleguide generator for front-end projects.'
  s.description         = s.summary

  s.files               = `git ls-files`.split("\n")
  s.test_files          = `git ls-files -- spec/*`.split("\n")
  s.executables         = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths       = ['lib']

  s.add_dependency 'redcarpet',       '~> 3.1'
  s.add_dependency 'activesupport',   '~> 4.2'
  s.add_dependency 'sass',            '~> 3.3'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'awesome_print', '~> 1.6'
end
