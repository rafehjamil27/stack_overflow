class QuestionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  skip_load_resource only: :create
  # GET /questions
  def index
    @questions, @title = Question.apply_filters(params, sort_column, sort_direction, current_user)
    
    respond_to do |format|
      format.html 
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /questions/new
  def new
    @question = Question.new

    respond_to do |format|
      format.html
    end
  end

  # GET /questions/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /questions
  def create
    @question = current_user.questions.new(question_params.except(:tag_names))
    respond_to do |format|
      if @question.save
        @question.add_tags params["question"][:tag_names]
        format.html { redirect_to @question, notice: "Question was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.assign_attributes(question_params)
    
    respond_to do |format|
      if @question.save
        @question.add_tags params["question"][:tag_names]
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy

    respond_to do |format|
      if @question.destroyed?
        format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      else
        format.html { redirect_to questions_url, notice: 'Unable to delete question.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body, :tag_names)
    end

    def sort_column
      Question.column_names.include?(params[:sort]) ? params[:sort] : "answer_count"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
