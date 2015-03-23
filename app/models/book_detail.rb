class BookDetail
  include Mongoid::Document
  field :isbn
  belongs_to :book, primary_key: :isbn
end
