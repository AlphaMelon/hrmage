class Document < ActiveRecord::Base
  belongs_to :employee

  mount_uploader :image, ImageUploader
end
