class Ability
  include CanCan::Ability

  def initialize(account, organization)
    # Define abilities for the passed in user here. For example:
    #
    account ||= Account.new # guest user (not logged in)
    organization ||= Organization.new
    acc_org = AccountOrganization.where(account_id: account.id, organization_id: organization.id).first
    
    if acc_org.nil?
      acc_org = AccountOrganization.new
    end
    
    if (acc_org.role == "Admin" || acc_org.role == "Super Admin") && !account.profile.nil?
      can :manage, :all
    elsif acc_org.role == "Employee" && !account.profile.nil? && account.profile.position.can_approve_leave
      can :create, Leave
      can :update, Leave do |leave|
        leave.try(:employee_id) != account.profile.id || account.profile.can_self_approve
      end
    elsif acc_org.role == "Employee" && !account.profile.nil? && account.profile.position.can_approve_claim
      can :create, Claim
      can :update, Claim do |claim|
        claim.try(:employee_id) != account.profile.id || account.profile.can_self_approve
      end
    else
      can :create, Organization
      can :create, Employee
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
