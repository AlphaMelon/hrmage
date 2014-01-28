module PositionSettingMacros

  def create_position_setting
    @position_setting_attr = FactoryGirl.attributes_for(:position_setting)
    @position_setting = PositionSetting.create!(@position_setting_attr)
    @position_setting.position = Position.first
    @position_setting.leave_type = LeaveType.first
    @position_setting.save
        
  end

  
end
