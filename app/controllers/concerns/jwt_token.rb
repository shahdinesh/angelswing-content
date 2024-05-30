# frozen_string_literal: true

#
# <Description>
#
module JwtToken
  extend ActiveSupport::Concern

  included do
    #
    # Encodes given payload into a JWT Token
    #
    # @param [Hash] payload
    #
    # @return [String] JWT token string
    #
    def encode_token(payload)
      jwt_secret = ENV.fetch("JWT_SECRET")
      JWT.encode(payload, jwt_secret)
    end

    #
    # Decodes JWT token sent in header payload
    #
    # @return [Hash] {id: } if valid token, else nil
    #
    def decoded_token
      bearer_token = request.headers["Authorization"]
      return unless bearer_token.present?

      jwt_secret = ENV.fetch("JWT_SECRET")
      # Break "Bearer TOKEN_STRING" into array and extract token only
      token = bearer_token.split.last

      begin
        JWT.decode(token, jwt_secret)
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
