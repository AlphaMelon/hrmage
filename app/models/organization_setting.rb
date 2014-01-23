class OrganizationSetting < ActiveRecord::Base
  belongs_to :organization
  has_many :organization_holidays, dependent: :destroy
  #validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, presence: true
  
  validate :at_least_one_day_is_working_day
  validate :cannot_be_negative_number
  
  def at_least_one_day_is_working_day
    if self.monday.nil? && self.tuesday.nil? && self.wednesday.nil? && 
    self.thursday.nil? && self.friday.nil? && self.saturday.nil? && self.sunday.nil? && 
      errors.add("Working Days",".There must be at least one working day in a week")
    end
  end
  
  def cannot_be_negative_number
    if !self.monday.nil?
      if 0 >= self.monday
        errors.add(:monday,"cannot be negative number or zero")
      end
    end

    if !self.tuesday.nil?
      if 0 >= self.tuesday
        errors.add(:tuesday,"cannot be negative number or zero")
      end
    end

    if !self.wednesday.nil?
      if 0 >= self.wednesday
        errors.add(:wednesday,"cannot be negative number or zero")
      end
    end
    
    if !self.thursday.nil?
      if 0 >= self.thursday
        errors.add(:thursday,"cannot be negative number or zero")
      end
    end

    if !self.friday.nil?
      if 0 >= self.friday
        errors.add(:friday,"cannot be negative number or zero")
      end
    end

    if !self.saturday.nil?
      if 0 >= self.saturday
        errors.add(:saturday,"cannot be negative number or zero")
      end
    end

    if !self.sunday.nil?
      if 0 >= self.sunday
        errors.add(:sunday,"cannot be negative number or zero")
      end
    end
  end 
end
