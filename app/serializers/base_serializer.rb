# frozen_string_literal: true

# BaseSerializer
class BaseSerializer
  include JSONAPI::Serializer

  DATETIME_FORMAT = "%Y-%m-%dT%H:%M%:z"

  set_key_transform :camel_lower
end
