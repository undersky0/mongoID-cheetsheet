class Vehicle
  include Mongoid::Document
  belongs_to :resources, polymorphic: true
end
