module OST
  class GetToken
    def self.perform
      response = RestClient.post(ENV['OST_AUTH_ENDPOINT'], {user: {email: ENV['OST_RR_EMAIL'],
                                                                   password: ENV['OST_RR_PASSWORD']}})
      JSON.parse(response.body)['token']
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end
