#require_relative '../config/environment.rb'
#binding.pry
# Ran this code after initial database migration to get Books, Author, and
# Category information into the database
#
# Parser.get_values.each do |row|
#   Author.create(name: row[1])
# end
#
# Parser.get_values.each do |row|
#   Category.create(name: row[2])
# end
#
# Parser.get_values.each.with_index(1) do |row, index|
#   Book.create(title: row[0], author_id: index, category_id: index)
# end
#
# User.create(name: "Franco")
