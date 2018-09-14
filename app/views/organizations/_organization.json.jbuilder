# frozen_string_literal: true

json.extract! organization, :id, :name, :address, :contact_name, :contact_phone, :created_at, :updated_at

json.url organization_url(organization, format: :json)

json.hqs organization.hq_data do |hq|
  json.extract! hq, 'id', 'name'

  json.country hq['country_name']
  json.store_count hq['store_count']

  json.stores hq['store_list']
end
