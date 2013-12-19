class Document < ActiveRecord::Base
  belongs_to :employee

  mount_uploader :image, ImageUploader
  
  validates :name, presence: true
end
