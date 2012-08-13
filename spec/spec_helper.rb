$:.push File.expand_path("lib")
$:.concat Dir["#{File.expand_path("lib")}/*/"]
$:.push File.expand_path("app")
$:.concat Dir["#{File.expand_path("app")}/*/"]

require 'bundler/setup'
require 'rubygems'
require "rspec"
require 'factory_girl'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
end

Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end