ActiveAdmin.register CountryHolidaySetting do
  
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  form do |f|
    f.inputs 'Details' do
      #f.input :country, :as => :string
      f.input :country_setting_id, as: :select, collection: Hash[CountrySetting.all.map{|cs| [cs.country,cs.id]}], include_blank: false
      f.input :name
      f.input :date
    end
    f.actions
  end
  
  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "/admin/country_holiday_settings/upload_csv.html.erb"
    # The method defaults to :get
    # By default Active Admin will look for a view file with the same
    # name as the action, so you need to create your view at
    # app/views/admin/posts/upload_csv.html.haml (or .erb if that's your weapon)
  end

  collection_action :import_csv, :method => :post do
    
    csv_file = params[:dump][:file].read
    CSV.parse(csv_file, :headers => :first_row) do |row|
      country_setting = CountrySetting.where(country: row[0]).first_or_create
      holiday_setting = CountryHolidaySetting.where(country_setting_id: country_setting.id, name: row[1]).first_or_initialize
      holiday_setting.date = row[2]#row[:date]
      holiday_setting.save
    end

    # Do some CSV importing work here...
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  index do
    column "Country", sortable: :country_setting_id do |country|
      country.country_setting.country
    end
    column :name
    column :date
    default_actions
  end
  
end
