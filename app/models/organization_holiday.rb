class OrganizationHoliday < ActiveRecord::Base
  belongs_to :organization_setting
  belongs_to :organization
  validates :name, :date, presence: true
end
