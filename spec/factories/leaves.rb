# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave do
    start_date "2014-01-15 00:00:00"
    comment "vacation"
    duration_seconds 172800
  end
end
