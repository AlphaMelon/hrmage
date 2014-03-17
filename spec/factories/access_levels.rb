# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_level do
    access_level "No Access"
    class_name "Leave"
  end
end
