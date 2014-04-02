# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee_variable do
    available_leaves_seconds 864000 #30 days
  end
end
