class VotesController < ApplicationController
  include CurrentUser
  before_action :set_user, only: [:create, :destroy]

  def create
    q_id = 0
    @multi_object = {}
    if params[:answer_id]
      answer = Answer.find(params[:answer_id])
      answer.votes.create(:user => @user, :count => 1) unless Vote.find_by(answer_id: params[:answer_id], user_id: @user.id)
      
      vote = answer.votes.find_by(user_id: @user.id)
      if vote
        vote.count += 1 unless vote.count > 0
        vote.save
      end

      q_id = answer.question.id
      @multi_object["obj"] = answer 
      @multi_object["select_id"] = "answer-vote-#{answer.id}"
    elsif params[:question_id]  
      question = Question.find(params[:question_id].to_i)
      question.votes.create(:user => @user, :count => 1) unless Vote.find_by(question_id: params[:question_id], user_id: @user.id)
      
      vote = question.votes.find_by(user_id: @user.id)
      if vote
        vote.count += 1 unless vote.count > 0
        vote.save
      end

      q_id = params[:question_id] 
      @multi_object["obj"] = question
      @multi_object["select_id"] = "question-vote-#{question.id}"
    end
    respond_to do |format|
      format.html { redirect_to question_url(q_id), notice: "Upvote added successfully!!!"}      
      format.js { @multi_object }
      format.json { render json: @multi_object }
    end
  end

  def destroy
    q_id = 0
    @multi_object = {}
    if params[:answer_id]
      answer = Answer.find(params[:answer_id])
      answer.votes.create(:user => @user, :count => -1) unless Vote.find_by(answer_id: params[:answer_id], user_id: @user.id)
      
      vote = answer.votes.find_by(user_id: @user.id)
      if vote
        vote.count -= 1 unless vote.count < 0
        vote.save
      end

      q_id = answer.question.id
      @multi_object["obj"] = answer 
      @multi_object["select_id"] = "answer-vote-#{answer.id}"
    elsif params[:question_id]  
      question = Question.find(params[:question_id].to_i)
      question.votes.create(:user => @user, :count => -1) unless Vote.find_by(question_id: params[:question_id], user_id: @user.id)
      
      vote = question.votes.find_by(user_id: @user.id)
      if vote
        vote.count -= 1 unless vote.count < 0
        vote.save
      end

      q_id = params[:question_id] 
      @multi_object["obj"] = question
      @multi_object["select_id"] = "question-vote-#{question.id}"
    end

    respond_to do |format|
      format.html { redirect_to question_url(q_id), notice: "Downvote added successfully!!!"}      
      format.js { @multi_object }
      format.json { render json: @multi_object }
    end
  end

end
