class QuestionsController < ApplicationController
  include CurrentUser
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :index]
  before_action :set_sidebar_tag
  # GET /questions
  # GET /questions.json
  def index
    if params[:search_txt]
      @title = "Search Results"
      @search_txt = params[:search_txt]
      @questions = Question.joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id").where("questions.title LIKE '%#{params[:search_txt]}%' OR questions.body LIKE '%#{params[:search_txt]}%' OR answers.body LIKE '%#{params[:search_txt]}%'").paginate(:page => params[:page])
    elsif params[:answered_by_me]
      @title = "Questions Asked By Me"
      @by_me = "active"
      @questions = @user.questions.paginate(:page => params[:page])
    elsif params[:answered]
      @title = "Answered Questions"
      @answered = "active"
      @questions = Question.joins(:answers).paginate(:page => params[:page])
    elsif params[:un_answered]
      @title = "Unanswered Questions"
      @un_answered = "active"
      @questions = Question.where('questions.id NOT IN (SELECT DISTINCT(question_id) FROM answers)').paginate(:page => params[:page])        
    else
      @title = "Top Questions"
      @top_q = "active"
      @questions = Question.paginate(:page => params[:page])
    end
    # sorting
    if params[:by_answers]
      @by_ans = "active"
      @questions = Question.select("questions.*, COUNT(answers.id) answer_count").joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id").group("questions.id").order("answer_count DESC").paginate(:page => params[:page])
    elsif params[:title]
      @by_title = "active"
      @questions = @questions.order(title: :asc)
    else
      @by_created_at = "active"
      @questions = @questions.order(created_at: :asc)
    end  
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = @user.questions.new(question_params.except(:tag_names))
    respond_to do |format|
      if @question.save
        @question.add_tags params["question"][:tag_names]
        format.html { redirect_to @question, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        @question.add_tags params["question"][:tag_names]
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_sidebar_tag
      @question_tag = "active"
    end
end
