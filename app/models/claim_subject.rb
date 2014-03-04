class ClaimSubject < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :organization
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
end
