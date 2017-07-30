require 'uri'

class Racer < ActiveRecord::Base
  has_many :race_entries
  
  before_save {
    self.email = self.email.downcase  
  }
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :gender, presence: true
  # validates :birth_date, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :birth_date, presence: true
  
  def name
    self.first_name + ' ' + self.last_name
  end
  
end