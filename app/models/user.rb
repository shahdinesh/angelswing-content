# frozen_string_literal: true

#
# Represents a user instance
#
# Attributes:
# * first_name (string): The user's first_name
# * last_name (string): The user's last_name
# * email (string): The user's email address.
# * password_digest (string): Encrypted password using BCrypt.
# * country (string): The user's country.
#
class User < ApplicationRecord
  ALPHABET_REGEX = /\A[a-zA-Z ]+\z/
  has_secure_password

  validates_presence_of :first_name, :last_name, :email
  validates :first_name, :last_name, format: { with: ALPHABET_REGEX, message: "can only contain letters and spaces" }
  validates :email, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP

  #
  # Set response of user data
  #
  # @param [String] JWT token
  #
  # @return [Hash] {id, type, attribute: {token, email, name, country}}
  #
  def format_response(token)
    {
      id: id,
      type: "users",
      attributes: {
        token: token,
        email: email,
        name: "#{first_name} #{last_name}",
        country: country
      }
    }
  end
end
