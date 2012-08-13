$:.push File.expand_path("../lib", __FILE__)
$:.concat Dir["#{File.expand_path("../lib", __FILE__)}/*/"]
$:.push File.expand_path("../app", __FILE__)
$:.concat Dir["#{File.expand_path("../app", __FILE__)}/*/"]

require 'bundler/setup'
require 'rubygems'
require 'pry'
require './app/app'

task :console do
 binding.pry
end