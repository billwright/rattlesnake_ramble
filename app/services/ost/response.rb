module OST
  class Response
    SUCCESSFUL_CODES = [200, 201]
    SHORTCUT_KEYS = %w[data errors token]

    delegate :body, :code, :headers, to: :rest_client_response

    def initialize(rest_client_response)
      @rest_client_response = rest_client_response
    end

    SHORTCUT_KEYS.each do |key|
      define_method(key) do
        parsed_body[key]
      end
    end

    def parsed_body
      JSON.parse(body)
    end

    def successful?
      SUCCESSFUL_CODES.include?(code)
    end

    private

    attr_reader :rest_client_response
  end
end
