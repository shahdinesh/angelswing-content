# frozen_string_literal: true

# UserSerializer
class UserSerializer < BaseSerializer
  set_type "users"

  attribute :token do |_user, params|
    params[:token]
  end

  attributes :email, :country, :created_at

  attribute :name do |user|
    "#{user.first_name} #{user.last_name}"
  end

  attribute :created_at do |user|
    user.created_at.strftime(DATETIME_FORMAT)
  end

  attribute :updated_at do |user|
    user.updated_at.strftime(DATETIME_FORMAT)
  end
end
