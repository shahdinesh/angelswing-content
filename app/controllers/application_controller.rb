# frozen_string_literal: true

#
# Base application controller
#
class ApplicationController < ActionController::API
  include JwtToken

  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :form_validation_error

  private

  #
  # Retrieve authenticated user detail send in header token
  #
  # @return [User] user instance
  #
  def authenticated_user
    @_authenticated_user ||= begin
      user_id = decoded_token&.dig(0, "id")

      User.find_by(id: user_id)
    end
  end

  #
  # Send form validation error message full message as response
  #
  # @param [ActiveRecord::RecordInvalid] model validation error object
  #
  # @return [Hash] {message: [...]}
  #
  def form_validation_error(form_error)
    render json: {message: form_error.record.errors.full_messages},
           status: :unprocessable_entity
  end

  #
  # Log the error and respond with internal server issue response
  #
  # @return [Hash] {message: "..."}
  #
  def standard_error(error)
    Rails.logger.error "Error while creating user: #{error.message}"

    render json: {message: "Something went wrong. Please try again later."},
           status: :internal_server_error
  end
end
