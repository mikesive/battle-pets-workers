#### REQUIRES
ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(ENV['RACK_ENV'].to_sym) # load all the environment specific gems

##### ENV VARS
require 'dotenv'
Dotenv.load

##### APP

require './app/workers/base_worker'
Dir.glob(File.expand_path('./app/**/*.rb')) { |file| require file }

##### CONFIG
Dir.glob(File.expand_path('./config/initializers/*.rb')) { |file| require file }
