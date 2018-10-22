class AnswersController < ApplicationController
  # POST /answers
  def create
    @question = Question.find(params[:question_id])

    @answers = @question.answers

    respond_to do |format|
      if @question.answers.create(:user => current_user, :body => params[:body])
        format.html { redirect_to question_url(@question), notice: "Answer added successfully!!" }      
        format.js { @answers = @question.answers }
      else
        format.html { redirect_to question_url(@question), alert: "Unable to add answer!!" }      
        format.js { @error = "Unable to add answer!!" }
      end
    end
  end

  # GET /answers/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /answers/1
  def update
    @answer.update(params.require(:post).permit(:body))

    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_url(@answer.question), notice: "Answer Updated Successfully!!" }
      else
        format.html { redirect_to question_url(@answer.question), alert: "Unable to update answer!!!" }
      end
    end
  end

  # DELETE /answers/1
  def destroy
    @question = Question.find(@answer.question.id)

    @answers = @question.answers
    @answer.destroy

    respond_to do |format|
      if @answer.destroyed?
        format.html { redirect_to question_url(@question), notice: "Answer deleted successfully!!" }      
        format.js { @answers = @question.answers }
      else
        format.html { redirect_to question_url(@question), alert: "Unable to delete answer" }
        format.js { @error = "Unable to delete answer" }
      end
    end
  end

  private

  def answer_params
    params.require(:post).permit(:body)
  end

end
