module LeaveTypeMacros

  def create_leave_type
    @leave_type_attr = FactoryGirl.attributes_for(:leave_type)
    @leave_type = LeaveType.new(@leave_type_attr)
    @leave_type.organization_id = Organization.first.id
    @leave_type.save
  end

  def create_leave_type_with_entitlement
    @leave_type_attr = FactoryGirl.attributes_for(:leave_type)
    @leave_type = LeaveType.new(@leave_type_attr)
    @leave_type.organization_id = Organization.first.id
    @leave_type.name = "Entitlement Leave"
    @leave_type.rules = "Entitlement Rules"
    @leave_type.default_count_seconds = 345600 #12 days
    @leave_type.save
  end
  
end
