class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :count
      t.references :question, index: true
      t.references :answer, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :questions
    add_foreign_key :votes, :answers
    add_foreign_key :votes, :users
  end
end
