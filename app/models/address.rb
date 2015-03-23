class Address
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :street, type: String
  field :city, type: String
  field :postcode, type: String
  field :country, type: String
  embedded_in :user
  embedded_in :publisher
end
