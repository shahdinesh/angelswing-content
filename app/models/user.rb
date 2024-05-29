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
end
