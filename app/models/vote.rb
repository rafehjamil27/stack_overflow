class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  def self.increment_vote(params, current_user)
    if params[:answer_id]
      answer = Answer.find(params[:answer_id])

      answer.votes.create(:user => current_user, :count => 1) unless Vote.find_by(answer_id: params[:answer_id], user_id: current_user.id)
      
      vote = answer.votes.find_by(user_id: current_user)

      if vote
        vote.count += 1 unless vote.count > 0
        vote.save
      end

      question = answer.question
      resource = answer
      select_id = "answer-vote-#{answer.id}"
    elsif params[:question_id]  
      question = Question.find(params[:question_id].to_i)
      question.votes.create(:user => current_user, :count => 1) unless Vote.find_by(question_id: params[:question_id], user_id: current_user.id)
      
      vote = question.votes.find_by(user_id: current_user.id)
      
      if vote
        vote.count += 1 unless vote.count > 0
        vote.save
      end
      
      resource = question
      select_id = "question-vote-#{question.id}"
    end

    return resource, select_id, question
  end

  def self.decrement_vote(params, current_user)
    if params[:answer_id]
      answer = Answer.find(params[:answer_id])
      answer.votes.create(:user => current_user, :count => -1) unless Vote.find_by(answer_id: params[:answer_id], user_id: current_user.id)
      
      vote = answer.votes.find_by(user_id: current_user.id)
      if vote
        vote.count -= 1 unless vote.count < 0
        vote.save
      end

      question = answer.question
      resource = answer 
      select_id = "answer-vote-#{answer.id}"
    elsif params[:question_id]  
      question = Question.find(params[:question_id].to_i)
      question.votes.create(:user => current_user, :count => -1) unless Vote.find_by(question_id: params[:question_id], user_id: current_user)
      
      vote = question.votes.find_by(user_id: current_user)
      if vote
        vote.count -= 1 unless vote.count < 0
        vote.save
      end
 
      resource = question
      select_id = "question-vote-#{question.id}"
    end

    return resource, select_id, question
  end
end
