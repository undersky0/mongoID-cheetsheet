class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :title, type: String
  field :price, type: Float
  field :page_count, type: Integer
  field :published_at, type: Date
  field :is_best_seller, type: Boolean, default: false
  field :awards, type: Array, default: []
  field :reviews, type: Hash, default: {}
  field :currency, localize: true
  field :isbn
  has_one :book_detail, primary_key: :isbn
  belongs_to :user, index: true, counter_cache: :books_count #books_count gets created with dynamic fields if doens't exist
  
  # RESERVED = {or: 0b0010}
  # PUBLISHED = {or: 0b0001}
  # DAMAGED = {or: 0b1000}
  # UNRESERVED = {and: 0b1101}
  
  #finding updating and returning new
  # Book.where(title: "new").find_and_modify({"$set" => {reserved:true, reserved_by: "wi
# llie"}},new:true)

# creates new attribute and sets it to 1 or adds n if already created
# inc - increment
# Book.last.inc(reserved_count: 1)
  
end
