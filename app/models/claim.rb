class Claim < ActiveRecord::Base


  before_save :set_default_values
  belongs_to :organization
  belongs_to :employee
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  validate :claims_cannot_be_more_than_available_claims
  validate :claims_cannot_be_zero_or_negative
  validates :subject, presence: true
  validates :date, presence: true
  validates :amount_cents, presence: true
  monetize :amount_cents, as: "amount"
  acts_as_paranoid
  mount_uploader :image, ImageUploader
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
  
  def set_default_values
    self.status = "Pending" if self.status.nil?
  end
  
  def claims_cannot_be_more_than_available_claims
    if !self.amount_cents.nil?
      if (self.employee.position.monthly_max_claims_cents - (self.employee.claims.where(status: "Approved", date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).sum :amount_cents)) < self.amount_cents
        errors.add(:amount_claims, "is more than your available claims")
      end
    end
  end
  
  def claims_cannot_be_zero_or_negative
    if !self.amount_cents.nil?
      if 0 >= self.amount_cents
        errors.add(:amount_claims, "cannot be 0 or negative")
      end
    end
  end
  
  def approve
    self.status = "Approved"
    employee = self.employee
    employee.save
    self.save
  end

  def reject
    self.status = "Rejected"
    self.save
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |claim|
        csv << claim.attributes.values_at(*column_names)
      end
    end
  end
end
