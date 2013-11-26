class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :documents
  
  mount_uploader :photo, ImageUploader
end
