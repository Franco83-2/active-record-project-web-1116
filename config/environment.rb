require_relative '../lib/parser.rb'
require 'bundler/setup'
Bundler.require
require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'
require 'sqlite3'
require 'pry'
require 'csv'
require 'rspec'
Bundler.require

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

ENV["LIBRARY_ENV"] ||= "development"

DBRegistry[ENV["LIBRARY_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["LIBRARY_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

def drop_db
  DB.tables.each do |table|
    DB.execute("DROP TABLE #{table}")
  end
end
