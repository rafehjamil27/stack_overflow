class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    if user.present?
      if user.is_admin?
        can :manage, :all
        cannot :delete, User, :is_admin => true
      else
        can :edit, User, :id => user.id
        can :read, User, :id => user.id
        cannot :destroy, user
        cannot :index, User

        can :manage, Question, :user_id => user.id
        can :read, Question
        can :manage, Answer, :user_id => user.id
        can :read, Answer
        can :manage, Comment, :user_id => user.id
        can :read, Comment
        can :manage, Vote
      end        
    else
      can :read, Question  
      can :read, Answer
      can :read, Comment
    end
  end
end
