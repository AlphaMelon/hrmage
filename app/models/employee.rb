class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  has_many :documents
  
  mount_uploader :photo, ImageUploader
end
