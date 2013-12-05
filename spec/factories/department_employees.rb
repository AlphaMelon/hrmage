# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department_employee do
    department_id 1
    employee_id 1
    leader false
  end
end
