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
  end
end
