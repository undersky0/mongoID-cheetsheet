class Vehicle
  include Mongoid::Document
  field :name, type: String
  belongs_to :resourceable, polymorphic: true
end
