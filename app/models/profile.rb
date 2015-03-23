class Profile
  include Mongoid::Document
  field :locations, type: Set
end