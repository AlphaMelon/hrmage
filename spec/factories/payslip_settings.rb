# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payslip_setting do
    name "EPF"
    value 10
    maths "Substraction Percentage"
  end
end
