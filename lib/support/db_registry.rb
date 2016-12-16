require 'ostruct'
require_relative './connection_adapter'
DBRegistry ||= OpenStruct.new(test: ConnectionAdapter.new("db/library-test.db"),
  development: ConnectionAdapter.new("db/library-development.db"),
  production: ConnectionAdapter.new("db/library-production.db")
)
