# frozen_string_literal: true

#
# Base application controller
#
class ApplicationController < ActionController::API
  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :form_validation_error

  private

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
