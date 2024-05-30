# frozen_string_literal: true

#
# Represents a content instance
#
# Attributes:
# * title (string): The content's title
# * body (string): The content's body
# * user_id (bigint): The content's owner user reference
#
class Content < ApplicationRecord
  validates_presence_of :title, :body

  belongs_to :user
end
