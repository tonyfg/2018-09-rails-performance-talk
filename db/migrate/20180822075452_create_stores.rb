# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :manager_name
      t.string :manager_email
      t.string :manager_phone_number

      t.belongs_to :hq, foreign_key: true

      t.timestamps
    end
  end
end
