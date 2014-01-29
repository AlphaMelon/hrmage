class EmployeeVariable < ActiveRecord::Base
  
  belongs_to :employee
  belongs_to :leave_type
  before_save :set_default_values
  
  def set_default_values
    if self.available_leaves_seconds.nil? #check whether available_leaves_second is nil or not
      if !self.employee.position.position_settings.blank?# check whether employee position got setting or not
        self.employee.position.position_settings.each do |position_setting| #for each position setting, a default employee variable will be create
          if position_setting.leave_type.id == self.leave_type.id #if position setting got same leave_type
            self.available_leaves_seconds = position_setting.max_leaves_seconds
            break
          else #position got no setting, use default count from leave_type
            self.available_leaves_seconds = self.leave_type.default_count_seconds
          end
        end
      else #position got no setting, use default count from leave_type
        self.available_leaves_seconds = self.leave_type.default_count_seconds
      end
    end
    
  end

end
