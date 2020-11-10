class Ability
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/MethodLength
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    # can :read, Article, { published: true }
    can :read, Article
    can :read, Category
    cannot %i[edit destroy create], Category
    cannot %i[edit destroy create], Article
    cannot :manage, User
    cannot :manage, :dashboard
    cannot :access, :rails_admin

    if user.superadmin_role?
      can :manage, :all
      can :manage, :dashboard # allow access to dashboard
      can :access, :rails_admin # only allow admin users to access Rails Admin
    end

    if user.moderator_role?
      can :manage, User
      can :manage, :dashboard
      can :manage, Article
      can :manage, Category
      cannot :access, :rails_admin
    end

    return unless user.user_role?

    can :manage, Article, { author_id: user.id }
    cannot :access, :rails_admin
    cannot %i[edit destroy create], Category

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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
