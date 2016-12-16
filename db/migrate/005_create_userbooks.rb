class CreateUserbooks < ActiveRecord::Migration
  def change
    create_table :userbooks do |t|
      t.integer :book_id
      t.integer :user_id
      t.boolean :returned
      t.string :issue_date
      t.string :return_date
      t.string :due_date
    end
  end
end
