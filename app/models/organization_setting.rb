class OrganizationSetting < ActiveRecord::Base
  belongs_to :organization
  has_many :organization_holidays, dependent: :destroy
  #validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, presence: true
end
