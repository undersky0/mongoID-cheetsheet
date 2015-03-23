class Publisher
  include Mongoid::Document
  
  field :name, type: String
  has_many :addresses
end