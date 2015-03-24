class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps # adds time stamps to records include Mongoid::Timestamps::Updated
  include Mongoid
  include Origin
  field :name, type: String
  field :books_count, type: Integer, default: 0
  
  scope :recent, ->{gte(created_at:Time.now - 1.day)}
  index({name:1,book_count:1}, {background:true})
  embeds_one :address
 # has_one :address#, after_add: :send_email
  validates_associated :address
  has_many :books, after_add: :send_email
  has_many :self_help_books, class_name: "Book"
  accepts_nested_attributes_for :books
  accepts_nested_attributes_for :address, reject_if: ->(attrs) { attrs[:postcode].blank? }
  
  has_many :vehicles, as: :resourceable
  has_many :self_help_books, class_name: "Book"
  
  #recursive self referencial structure u.child_users.first.parent_user
  embeds_many :child_users, class_name: "User", cyclic:true
  embedded_in :parent_user, class_name: "User", cyclic:true
  #OR recursively_embeds_many
  
  validates :name, presence: true
  
  # default quary selectors
  # User.exists(books_count: true)
  # User.all(name:['a','adsasda']) name must contain atleast those values
  # User.gt(books_count:1) 
  # User.where(:created_at.lte => Time.now)
  # gt - Greater than. gte - greater than or equal. lt - lesser than. lte = lesser than or euqal
  # User.in(name:['bill','rich']) - finds all with those names
  # User.nin(name:['bill','rich']) - finds all without those names
  # User.where(name: "rich")
  # User.near('address.locaiton' => [51,-111]) - only works if fields are indexed in 2D
 # User.in(rewards: ['first place', 'second place']) - finds all where rewards is either or both
 # User.where(rewards: ["firstplance","sencond place"]).first - finds all mathcing
 
 # u.where('books.title' = /new/).first to search within the embeded documents
  # u = User.where(name: "John").find_and_modify({ '$set' => { name:
# "LOL:)"} }, new: true) - find and modify and reload
#   User.all.avg(:books_count) - gets avarage of all book counts
# User.all.collect {|a| [a.name, a.books.count]} 
#  => [["dasdsa", 0], ["1", 0], ["dsa1", 0],

# srch = Mongoid::Contextual::TextSearch.new(User.collection,
# User.all, 'john')
# def map_reduce
# map = %q{function() {emit(this.name.toLowerCase()[0], {count:1});}}
# reduce = %q{function(key, values) {var r = { count: 0 };values.forEach(function(value) {r.count += value.count;})return r;}}
# end

  def send_email(book)
    puts "Send email: #{book.inspect}"
    puts "Send email: #{self.inspect}"
  end
end
