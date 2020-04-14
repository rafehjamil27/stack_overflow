class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.references :tag, index: true
      t.belongs_to :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :question_tags, :tags
    add_foreign_key :question_tags, :questions
  end
end
