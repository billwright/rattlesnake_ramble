module OST
  class GetToken
    def self.perform
      full_url = "#{ENV['OST_URL']}#{OST::Constants::AUTH_ENDPOINT}"
      response = RestClient.post(full_url, {user: {email: ENV['OST_RR_EMAIL'],
                                                   password: ENV['OST_RR_PASSWORD']}})
      OST::Response.new(response)

    rescue RestClient::ExceptionWithResponse => e
      OST::Response.new(e.response)
    end
  end
end
