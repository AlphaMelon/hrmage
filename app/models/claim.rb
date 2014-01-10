class Claim < ActiveRecord::Base

  before_save :set_default_values
  belongs_to :organization
  belongs_to :employee
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  validate :claims_cannot_be_more_than_available_claims
  validates :subject, presence: true
  validates :date, presence: true
  validates :amount_cents, presence: true
  monetize :amount_cents, as: "amount"
  
  mount_uploader :image, ImageUploader
  

  def set_default_values
    self.status = "Pending" if self.status.nil?
  end
  
  def claims_cannot_be_more_than_available_claims
    if !self.amount_cents.nil?
      if self.employee.available_claims_cents < self.amount_cents
        errors.add(:amount_claims, "is more than your available claims")
      end
    end
  end
end
