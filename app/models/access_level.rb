class AccessLevel < ActiveRecord::Base

  belongs_to :account_organization
  belongs_to :department
    
end
