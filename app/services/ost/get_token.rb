module OST
  class GetToken
    def self.perform
      full_url = "#{ENV['OST_URL']}#{OST::Constants::AUTH_ENDPOINT}"
      response = RestClient.post(full_url, {user: {email: ENV['OST_RR_EMAIL'],
                                                   password: ENV['OST_RR_PASSWORD']}})
      JSON.parse(response.body)['token']
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end
