class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_default_values
  validates :email, uniqueness: true
  
  has_many :profiles, class_name: "Employee"
  has_many :account_organizations, dependent: :destroy
  has_many :organizations, :through => :account_organizations
  
  def set_default_values
    #self.role = "Super Admin" if self.role.blank?
  end

end
