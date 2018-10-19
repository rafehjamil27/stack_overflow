class VotesController < ApplicationController
  # POST /votes
  def create
    @resource, @select_id, question = Vote.increment_vote(params, current_user) 

    respond_to do |format|
      format.html { redirect_to question_url(question), notice: "Upvote added successfully!!!"}      
      format.js
    end
  end

  # DELETE /votes/1
  def destroy
    @resource, @select_id, question = Vote.decrement_vote(params, current_user)

    respond_to do |format|
      format.html { redirect_to question_url(question), notice: "Downvote added successfully!!!"}      
      format.js 
    end
  end
end
