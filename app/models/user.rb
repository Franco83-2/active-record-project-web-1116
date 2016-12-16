class User < ActiveRecord::Base
  has_many :userbooks
  has_many :books, through: :userbooks

  def self.who_are_you
    query = gets.strip
    self.where(name: query).first
  end


end
