class LeaseSerializer < ActiveModel::Serializer
  attributes :rent
  
  belongs_to :apartment
  belongs_to :tenant

end
