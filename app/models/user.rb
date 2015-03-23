class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid
  include Origin
  field :name, type: String
  field :books_count, type: Integer, default: 0

  embeds_one :address
  has_one :address#, after_add: :send_email
  validates_associated :address
  has_many :books, after_add: :send_email
  has_many :self_help_books, class_name: "Book"
  accepts_nested_attributes_for :books
  accepts_nested_attributes_for :address, reject_if: ->(attrs) { attrs[:postcode].blank? }
  
  has_one :vehicle, as: :resource
  has_many :self_help_books, class_name: "Book"
  
  validates :name, presence: true
  
  def send_email(book)
    puts "Send email: #{book.inspect}"
    puts "Send email: #{self.inspect}"
  end
end
