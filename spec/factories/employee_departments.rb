# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee_department do
    employee_id 1
    department_id 1
    is_leader false
  end
end
