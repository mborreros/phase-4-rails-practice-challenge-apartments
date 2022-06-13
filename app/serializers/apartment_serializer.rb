class ApartmentSerializer < ActiveModel::Serializer
  attributes :number

  has_many :leases
  has_many :tenants

end
