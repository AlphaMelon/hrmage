class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :position
  has_many :documents
  
  has_many :employee_departments
  has_many :departments, through: :employee_departments
  
  mount_uploader :photo, ImageUploader
  
  
  def department_names
    departments.collect{|d| d.name}.join(', ')
  end
 
  # virtual attribute department_ids - an array of integers
  # corresponds to the ids of the departments
  def department_ids
    @department_ids || departments.collect{|d| d.id}
  end
 
  def department_ids=(id_array)
    @department_ids = id_array.collect{|id| id.to_i};
  end
 
  after_save :assign_departments
 
  private
 
  # create or remove Employee_department records so that Employee is
  # associated with the departments specified in @department_ids
  def assign_departments
  #raise @department_ids.inspect
    if @department_ids
      new_ids = @department_ids
      old_ids = departments.collect{|d| d.id}
      ids_to_delete = old_ids - (old_ids & new_ids)
      ids_to_add = new_ids - (old_ids & new_ids)
      department_id = id
 
      ids_to_delete.each do |department_id|
        EmployeeDepartment.destroy_all(:employee_id => employee_id, :department_id => department_id)
      end
 
      ids_to_add.each do |department_id|
        Employee.create(:employee_id => employee_id, :department_id => department_id)
      end
    end
  end
end
