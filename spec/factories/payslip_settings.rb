# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payslip_setting do
    organization_id 1
    name "Socso"
    value 10
    maths "Substraction Percentage"
  end
end
