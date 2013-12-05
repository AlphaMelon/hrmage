module DepartmentMacros

  def create_department
    @department_attr = FactoryGirl.attributes_for(:department)
    @department = Department.create!(@department_attr)
    @department.organization_id = Organization.first.id
    @department.save
  end

  
end
