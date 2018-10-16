class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    if user 
        if user.is_admin?
            can :manage, :all
            cannot :delete, User, :is_admin => true
        else
            can :read, User, :id => user.id 
            can :create, User
            can :update, User, :id => user.id
            can :read, Question  
            can :create, Question
            can :update, Question, :user_id => user.id 
            can :delete, Question, :user_id => user.id
            can :read, Answer
            can :create, Answer
            can :update, Answer, :user_id => user.id
            can :delete, Answer, :user_id => user.id
            can :read, Comment
            can :create, Comment
            can :update, Comment, :user_id => user.id
            can :delete, Comment, :user_id => user.id
        end        
    else
        can :read, Question  
        can :read, Answer
        can :read, Comment
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
