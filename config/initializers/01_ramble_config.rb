# frozen_string_literal: true

module RambleConfig
  def self.ost_email
    ENV["OST_EMAIL"]
  end

  def self.ost_password
    ENV["OST_PASSWORD"]
  end

  def self.ost_url
    ENV["OST_URL"].presence || "https://www.opensplittime.org"
  end
end
