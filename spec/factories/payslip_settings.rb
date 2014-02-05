# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payslip_setting do
    organization_id 1
    name "MyString"
    value 1
    maths "MyString"
  end
end
