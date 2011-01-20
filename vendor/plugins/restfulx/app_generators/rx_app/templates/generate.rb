#!/usr/bin/env ruby
APP_ROOT = File.join(File.dirname(__FILE__), '..')

begin
  require 'rubigen'
rescue LoadError
  require 'rubygems'
  require 'rubigen'
end
require 'rubigen/scripts/generate'
require 'activesupport'
require 'restfulx'

ARGV.shift if ['--help', '-h'].include?(ARGV[0])

RubiGen::Base.use_component_sources! [:rxgen]
RubiGen::Scripts::Generate.new.run(ARGV)