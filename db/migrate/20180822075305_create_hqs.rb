# frozen_string_literal: true

class CreateHqs < ActiveRecord::Migration[5.2]
  def change
    create_table :hqs do |t|
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.belongs_to :organization, foreign_key: true
      t.belongs_to :country, foreign_key: true

      t.timestamps
    end
  end
end
