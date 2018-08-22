# frozen_string_literal: true

class Hq < ApplicationRecord
  belongs_to :organization
  belongs_to :country
  has_many :stores
end
