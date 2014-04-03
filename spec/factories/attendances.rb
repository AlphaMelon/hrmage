# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    organization_id 1
    employee_id 1
    clock_id 1
    clock_time "2014-04-03 14:53:39"
  end
end
