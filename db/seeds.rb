# frozen_string_literal: true

if ENV['SMALL_SEEDS']
  total_countries = 10
  total_orgs = 3
  hqs_per_org = 2
  stores_per_hq = 1
else
  total_countries = 50
  total_orgs = 30
  hqs_per_org = 30
  stores_per_hq = 100
end

Organization.transaction do
  (total_orgs - Organization.count).times do
    Organization.create(
      name: FFaker::Company.name,
      address: FFaker::Address.street_address,
      contact_name: FFaker::Name.name,
      contact_phone: FFaker::PhoneNumber.phone_number
    )
  end

  (total_countries - Country.count).times do
    Country.create(
      name: FFaker::Address.country,
      code: FFaker::Address.country_code
    )
  end

  Organization.find_each do |org|
    (hqs_per_org - org.hqs.count).times do
      org.hqs.create(
        name: FFaker::Company.name,
        country: Country.order(Arel.sql('random()')).first,
        address: FFaker::Address.street_address,
        contact_name: FFaker::Name.name,
        contact_phone: FFaker::PhoneNumber.phone_number
      )
    end
  end

  Hq.find_each do |hq|
    base_count = stores_per_hq - hq.stores.count
    (base_count..base_count + 5).to_a.sample.times do
      hq.stores.create(
        name: FFaker::Company.name,
        address: FFaker::Address.street_address,
        phone_number: FFaker::PhoneNumber.phone_number,
        manager_name: FFaker::Name.name,
        manager_email: FFaker::Internet.email,
        manager_phone_number: FFaker::PhoneNumber.phone_number
      )
    end
  end
end
