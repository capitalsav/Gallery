# frozen_string_literal: true

# User which have access to admin panel
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }
end
