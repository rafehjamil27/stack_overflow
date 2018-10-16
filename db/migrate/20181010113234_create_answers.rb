class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :answers, :questions
    add_foreign_key :answers, :users
  end
end
