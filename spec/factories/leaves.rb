# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave do
    start_date Date.today
    comment "vacation"
    duration_seconds 259200 #3 days
  end
end
