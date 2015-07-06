require 'rubygems'
require 'rspec'
require 'pry'
require 'codeclimate-test-reporter'

RSpec.configure do |config|
   config.color = true
   config.tty = true
   config.formatter = :documentation # :documentation, :progress, :html, :textmate
end

CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('lib')
require 'forwarding_dsl'

$LOAD_PATH.unshift File.expand_path('spec/support')

