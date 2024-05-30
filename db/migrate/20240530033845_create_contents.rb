# frozen_string_literal: true

#
# Table to store user's content information
#
class CreateContents < ActiveRecord::Migration[7.0]
  #
  # Schema definition for content table
  #
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
