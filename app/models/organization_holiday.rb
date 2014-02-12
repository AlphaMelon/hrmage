class OrganizationHoliday < ActiveRecord::Base
  belongs_to :organization_setting
  belongs_to :organization
  validates :name, :date, presence: true
  
  def self.holiday?(organization_id, date)
    return Organization.find(organization_id).organization_holidays.where(date: date).first
  end
  
end
