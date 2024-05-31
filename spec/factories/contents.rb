# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    title { "Applications" }
    body { "Tempora aperiam minus itaque. Omnis quam adipisci. Quasi eum labore impedit placeat dolores rem ut sit." }

    user
  end
end
