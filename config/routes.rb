Hrmage::Application.routes.draw do

  devise_for :accounts, :controllers => { :registrations => "registrations" }
  resources :accounts, :only => [:show]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'my_leaves' => "home#my_leaves"
  get 'my_claims' => "home#my_claims"
  get 'my_salary' => "home#my_salary"
  get 'my_salary_show/:payslip_id' => "home#my_salary_show"
  get 'sign_in' => "home#sign_in"
  get 'sign_up' => "home#sign_up"
  get 'calendar' => "home#calendar"
  get 'print_salary' => "home#print_salary"
  get 'approvals' => "home#approvals"
  resources :organizations do
    resources :claim_subjects
    resources :activities
    resources :payslip_settings
    resources :claims
    resources :positions do
      resources :position_settings
    end
    resources :account_organizations do
      resources :access_levels
    end
    resources :departments
    resources :leaves
    resources :leave_types
    resources :organization_settings do
      resources :organization_holidays do
        post 'get_and_update_holiday' => "organization_holidays#get_and_update_holiday"
      end
    end
    resources :employees do
      resources :payslips
      resources :employee_variables
      resources :employee_departments
      resources :documents
      get 'edit_login_info' => 'employees#edit_login_info'
      patch 'edit_login_info' => 'employees#update_login_info'
      get 'new_login' => 'employees#new_login'
      post 'new_login' => 'employees#create_login'
    end
    post 'end_of_year_action' => 'organizations#end_of_year_action'
  end
  resources :after_signup
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
