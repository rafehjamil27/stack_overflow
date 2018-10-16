class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :question, index: true
      t.references :answer, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :questions
    add_foreign_key :comments, :answers
    add_foreign_key :comments, :users
  end
end
