class Document < ActiveRecord::Base
  belongs_to :employee

  mount_uploader :image, ImageUploader
  
  validates :name, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| controller.current_organization.id }
end
