# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave_type do
    name "Annual leave"
    approval_needed true
    description "yearly leaves"
    affected_entity ["count", "salary"]
    type "LeaveSubstraction"
    default_count_seconds 1209600 #14 days
    colour "#f3f3f3"
  end
end
