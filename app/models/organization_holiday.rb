class OrganizationHoliday < ActiveRecord::Base
  belongs_to :organization_setting
  belongs_to :organization
  validates :name, :date, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| controller.current_organization.id }
  
  def self.holiday?(organization_id, date)
    return Organization.find(organization_id).organization_holidays.where(date: date).first
  end
  
end
