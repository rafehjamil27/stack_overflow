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
    
    def self.apply_filters(params, sort_column, sort_direction, current_user)
      @questions = Question.select("questions.* ,COUNT(answers.id) answer_count").joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id").group("questions.id").paginate(:page => params[:page])
      
      if params[:filter] == "search"
        @title = "Search Results"
        @search_txt = params[:search_txt]
        @questions = @questions.where("questions.title LIKE '%#{@search_txt}%' OR questions.body LIKE '%#{@search_txt}%' OR answers.body LIKE '%#{@search_txt}%'")
      elsif params[:filter] == "answered_by_me"
        @title = "Questions Asked By Me"
        @by_me = "active"
        @questions = @questions.where("questions.user_id = #{current_user.id}")
      elsif params[:filter] == "answered"
        @title = "Answered Questions"
        @answered = "active"
        @questions = @questions.where("answers.id IS NOT NULL")
      elsif params[:filter] == "un_answered"
        @title = "Unanswered Questions"
        @un_answered = "active"        
        @questions = @questions.where("answers.id IS NULL")
      else
        @title = "Top Questions"
        @top_q = "active"
      end
      
      # sorting
      @questions = @questions.order(sort_column + " " + sort_direction)
      return @questions, @title
    end
end
