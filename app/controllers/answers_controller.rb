class AnswersController < ApplicationController
  include CurrentUser
  before_action :set_user, only: [:create, :edit]
  before_action :set_answer, only: [:edit, :update, :destroy]

  def new
  end

  def create
    q = Question.find(params[:question_id])
    q.answers.create(:user => @user, :body => params[:body])

    respond_to do |format|
      format.html { redirect_to question_url(q.id), notice: "Answer added successfully!!" }      
      format.js { @answers = q.answers }
      format.json { render json: @answers}
    end
  end

  def edit
      redirect_to questions_url, notice: "You can not edit this answer" unless @user.id == @answer.user.id
  end

  def update
    @answer.update(params.require(:post).permit(:body))
    redirect_to question_url(@answer.question.id.to_s), notice: "Answer Updated Successfully!!"
  end

  def destroy
    q = Question.find(@answer.question.id)
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_url(q.id), notice: "Answer added successfully!!" }      
      format.js { @answers = q.answers }
      format.json { render json: @answers}
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

end
