# frozen_string_literal: true

module Api
  module V1
    #
    # Handle user sign in action
    #
    class AuthController < ApplicationController
      #
      # Endpoint to handle sing in of user
      # POST /auth/signin
      # @params [Hash] {:email, :password}
      #
      # @return [Hash] {user: {...}, token: "..."}
      #
      def sign_in
        user = User.find_by(email: sign_in_params[:email])
        unless user.present?
          return render json: {message: "User not found with email #{sign_in_params[:email]}"},
                        status: :not_found
        end

        unless user.authenticate(sign_in_params[:password])
          return render json: {message: "Invalid login or password."},
                        status: :unauthorized
        end

        token = encode_token({id: user.id})

        render json: user.format_response(token)
      end

      private

      #
      # Only allow a list of trusted parameters through.
      #
      def sign_in_params
        params.require(:auth).permit(:email, :password)
      end
    end
  end
end
