module OST
  class GetToken
    def self.perform
      full_url = "#{RambleConfig.ost_url}#{OST::Constants::AUTH_ENDPOINT}"
      response = RestClient.post(full_url, {user: {email: RambleConfig.ost_email,
                                                   password: RambleConfig.ost_password}})
      OST::Response.new(response)

    rescue RestClient::ExceptionWithResponse => e
      OST::Response.new(e.response)
    end
  end
end
