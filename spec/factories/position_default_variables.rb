# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_default_variable do
    position_id 1
    leave_type_id 1
    max_leaves_seconds 1
  end
end
