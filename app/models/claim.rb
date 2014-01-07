class Claim < ActiveRecord::Base

  before_save :set_default_values
  belongs_to :organization
  belongs_to :employee
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  
  validates :subject, presence: true
  validates :date, presence: true
  validates :amount_cents, presence: true
  monetize :amount_cents
  
  mount_uploader :image, ImageUploader
  

  def set_default_values
    self.status = "Pending" if self.status.nil?
  end
  
end
