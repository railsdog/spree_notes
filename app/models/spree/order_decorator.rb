Spree::Order.class_eval do
  has_many :notes, as: :noteable
end
