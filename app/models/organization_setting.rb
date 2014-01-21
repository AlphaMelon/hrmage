class OrganizationSetting < ActiveRecord::Base
  belongs_to :organization
  has_many :organization_holidays, dependent: :destroy
  #validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, presence: true
  
  validate :at_least_one_day_is_working_day
  
  def at_least_one_day_is_working_day
    if self.monday.nil? && self.tuesday.nil? && self.wednesday.nil? && 
    self.thursday.nil? && self.friday.nil? && self.saturday.nil? && self.sunday.nil? && 
      errors.add("There must be at least one working day in a week")
    end
  end
end
