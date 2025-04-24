class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role check helpers
  def admin?
    role == 'admin'
  end

  def creator?
    role == 'creator'
  end

  def reader?
    role == 'reader'
  end

  # Default role
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'reader'
  end
end
