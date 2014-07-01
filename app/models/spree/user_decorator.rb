Spree.user_class.class_eval do
  has_many :notes, as: :noteable
end
