class CommentsController < ApplicationController
  load_and_authorize_resource
  # GET /comments/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /comments
  def create
    resource = params[:question_id] ? Question.find(params[:question_id]) : Answer.find(params[:answer_id])
  
    @comment_id = "comments"
    @comment_id += "-#{resource.id}" if params[:answer_id]

    question = params[:question_id] ? resource.id : resource.question_id
    @comments = resource.comments

    comment = resource.comments.build(user: current_user, body: params[:body])

    respond_to do |format|
      if comment.save
        format.html { redirect_to question_url(question), notice: "Comment added successfully!!!" }      
        format.js
      else
        format.html { redirect_to question_url(question), alert: "Unable to add comment!!!" }      
        format.js { @error = "Unable to add comment" }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    question = @comment.question ? @comment.question : @comment.answer.question

    @comment.assign_attributes(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to question_url(question), notice: "Comment Updated Successfully!!" }
      else
        format.html { redirect_to question_url(question), alert: "Unable to update comment!!" }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    question = @comment.question ? @comment.question : @comment.answer.question 
    
    @comment.destroy

    respond_to do |format|
      if @comment.destroyed?
        format.html {redirect_to question_url(question), notice: "Comment deleted successfully!!!"} 
      else
        format.html {redirect_to question_url(question), alert: "Unable to delete comment"}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end