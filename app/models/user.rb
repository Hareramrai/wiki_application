class User < ApplicationRecord
  include Gravtastic
  include RoleManager
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_role
  has_one :role, through: :user_role
  has_many :articles

  before_create :set_default_role
  
  gravtastic :secure => true, :filetype => :gif, :size => 120

  delegate :name, to: :role, prefix: true, allow_nil: true

  private 
  def set_default_role
    default_role = ENV.fetch('DEFAULT_ROLE') { 'Author' }
    self.role ||= Role.where(name: default_role).first_or_create!
  end
end
