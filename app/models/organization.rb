# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :hqs
  has_many :stores, through: :hqs
end
