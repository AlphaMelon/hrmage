# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leafe, :class => 'Leave' do
    start_date ""
    end_date ""
    comment ""
    leave_type ""
    properties ""
  end
end
