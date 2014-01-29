# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee_variable do
    available_leaves_seconds 864000 #10 days
  end
end
