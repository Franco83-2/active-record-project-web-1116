class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :userbooks
  has_many :users, through: :userbooks

  def self.available

  end

  # def self.unavailable
  #   self.joins(:userbooks).where(userbooks: {returned: nil})
  # end
end
