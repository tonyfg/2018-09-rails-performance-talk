# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone

      t.timestamps
    end
  end
end
