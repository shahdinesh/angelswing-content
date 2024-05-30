# frozen_string_literal: true

module Api
  module V1
    #
    # Handle user sign up action
    #
    class UsersController < ApplicationController
      #
      # Endpoint to handle creation of user
      # POST /users/signup
      # @params [Hash] {:firstName, :lastName, :email, :password, :country}
      #
      # @return [Hash] {user: {...}, token: "..."}
      #
      def create
        # Convert camelCase parameter to snake_case
        user_attributes = user_params.transform_keys(&:underscore)
        user = User.create!(user_attributes)
        token = encode_token({id: user.id})

        render json: UserSerializer.new(user, params: {token:}), status: :created
      end

      private

      #
      # User permitted model attributes
      #
      # @return [Hash] {:firstName, :lastName, :email, :password, :country}
      #
      def user_params
        params.permit(:firstName, :lastName, :email, :password, :country)
      end
    end
  end
end
