require 'uri'

class Racer < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :gender, presence: true
  # validates :birth_date, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :birth_date, presence: true
end