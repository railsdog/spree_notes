class Spree::Note < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true
  validates_presence_of :author
  default_scope order(important: :desc, created_at: :desc)

  def self.important
    where(important: true)
  end

  def self.not_important
    where(important: false)
  end
end
