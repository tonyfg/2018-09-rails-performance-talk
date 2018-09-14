# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :hqs
  has_many :stores, through: :hqs

  scope :with_hq_names_and_store_count, -> do
    select(%(
      organizations.*,
      (SELECT array_agg(
                hqs.name ||
                ':' ||
                countries.name ||
                '(' ||
                (SELECT count(id) FROM stores WHERE stores.hq_id = hqs.id) ||
                ')'
              )
       FROM hqs
       JOIN countries ON countries.id = hqs.country_id
       WHERE hqs.organization_id = organizations.id
      ) AS hq_data
    ))
  end

  scope :with_hq_and_store_names, -> do
    select(%(
      organizations.*,
      (SELECT array_agg(json_build_object(
                'id', hqs.id,
                'name', hqs.name,
                'country_name', countries.name,
                'store_count', (SELECT count(id) FROM stores WHERE stores.hq_id = hqs.id),
                'store_list', (SELECT array_agg(json_build_object('id', id, 'name', name)) FROM stores WHERE stores.hq_id = hqs.id)
              ))
       FROM hqs
       JOIN countries ON countries.id = hqs.country_id
       WHERE hqs.organization_id = organizations.id
      ) AS hq_data
    ))
  end
end
