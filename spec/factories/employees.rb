# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    employee_identification "STN001"
    first_name "David"
    last_name "Wong"
    mobile_contact "016123214"
    base_salary_cents 300000
  end
end
