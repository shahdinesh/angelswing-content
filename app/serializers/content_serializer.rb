# frozen_string_literal: true

# ContentSerializer
class ContentSerializer < BaseSerializer
  set_type "content"

  attributes :title, :body

  attribute :created_at do |content|
    content.created_at.strftime(DATETIME_FORMAT)
  end

  attribute :updated_at do |content|
    content.updated_at.strftime(DATETIME_FORMAT)
  end
end
