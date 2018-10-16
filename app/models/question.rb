class Question < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :question_tags, dependent: :destroy
	has_many :tags, through: :question_tags
	has_many :answers, dependent: :destroy
	has_many :votes, dependent: :destroy

  self.per_page = 10
	attr_accessor :tag_names

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true

  	def add_tags(tags)
  		tags.each do |tag|
  			current_question_tag = question_tags.find_by(tag_id: tag)
  			question_tags.create(:tag => Tag.find(tag)) unless tag == "" ||	current_question_tag
  		end
  	end
end
