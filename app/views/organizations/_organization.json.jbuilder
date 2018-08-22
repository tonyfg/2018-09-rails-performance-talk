# frozen_string_literal: true

json.extract! organization, :id, :name, :address, :contact_name, :contact_phone, :created_at, :updated_at

json.url organization_url(organization, format: :json)

json.hqs organization.hqs do |hq|
  json.extract! hq, :id, :name

  json.country hq.country.name
  json.store_count hq.stores.count

  json.stores hq.stores do |store|
    json.extract! store, :id, :name
  end
end
