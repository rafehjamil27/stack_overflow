class CommentsController < ApplicationController
  include CurrentUser
  before_action :set_user, only: [:create]
  before_action :set_comment, only: [:update, :edit, :destroy]

  def show
  end

  def edit
  end

  def update
  	@comment.update(params.require(:post).permit(:body))
    redirect_to question_url(@comment.question.id.to_s), notice: "Comment Updated Successfully!!" if @comment.question
    redirect_to question_url(@comment.answer.question.id.to_s), notice: "Comment Updated Successfully!!" if @comment.answer
  end

  def create
    ob = Question.find(params[:question_id]) if params[:question_id]
  	ob = Answer.find(params[:answer_id]) if params[:answer_id]
  	ob.comments.create(:user => @user, :body => params[:body])
  
    @comment_id = "comments"
    @comment_id += "-#{ob.id}" if params[:answer_id]

    respond_to do |format|
      format.html { redirect_to question_url(ob.id), notice: "Comment added successfully!!!" } if params[:question_id]      
      format.html { redirect_to question_url(ob.question_id), notice: "Comment added successfully!!!" } if params[:answer_id]
      format.js { @comments = ob.comments }
      format.json { render json: @comment_id }
    end
    # redirect_to question_url(5), notice: "#{params}"
  end

  def destroy
    q_id = @comment.question.id if @comment.question
    q_id = @comment.answer.question.id if @comment.answer
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to question_url(q_id), notice: "Comment deleted successfully!!!"}
      format.js 
      format.json { render json: q_id }
    end
  end

  private

  def set_comment
  	@comment = Comment.find(params[:id])
  end

end