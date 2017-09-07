class GetOstToken

  def self.perform
    response = RestClient.post('https://www.opensplittime.org/api/v1/auth', {user: {email: ENV['OST_RR_EMAIL'],
                                                                                   password: ENV['OST_RR_PASSWORD']}})
    JSON.parse(response.body)['token']
  end
end
