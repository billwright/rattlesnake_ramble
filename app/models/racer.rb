class Racer < ActiveRecord::Base
  has_many :race_entries

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save {
    self.email = self.email.downcase  
  }
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :birth_date, presence: true
  
  def name
    [first_name, last_name].join(' ')
  end
  
  def current_age
    now = Time.now.utc.to_date
    dob = self.birth_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  def home_location
    [city.presence, state.presence].compact.join(', ')
  end
end
