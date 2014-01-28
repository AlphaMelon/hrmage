# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara-webkit'
require 'rack/utils'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.include(AccountMacros)
  config.include(DocumentMacros)
  config.include(DepartmentMacros)
  config.include(OrganizationMacros)
  config.include(PositionMacros)
  config.include(PositionSettingMacros)
  config.include(LeaveTypeMacros)
  config.include(LeaveMacros)
  config.include(EmployeeMacros)
  config.include(ClaimMacros)
  config.include(OrganizationSettingMacros)
  config.include(OrganizationHolidayMacros)
  config.include(PageMacros)
  config.include(FirstTimeSignupMacros)
  config.before(:each) do
    Capybara.javascript_driver = :webkit
    #Capybara.always_include_port = true
    Capybara.app_host = "http://staff.alphamelon.dev:#{Capybara.server_port}/?beta=1"
    
    Employee.delete_all
    Account.delete_all
    Department.delete_all
    Document.delete_all
    Organization.delete_all
    Position.delete_all
    PositionSetting.delete_all
    Leave.delete_all
    LeaveType.delete_all
    AccountOrganization.delete_all
    EmployeeDepartment.delete_all
    Claim.delete_all
    OrganizationSetting.delete_all
    OrganizationHoliday.delete_all
    
    create_admin_account
    create_organization
    create_department
    create_position
    create_employee
    create_document
    create_leave_type
    create_leave
    create_claim
    create_position_setting
  end
end
