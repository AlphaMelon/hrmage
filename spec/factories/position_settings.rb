# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_setting do
    max_leaves_seconds 1814400 #63 days
  end
end
