class Spree::Note < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true

  validates_presence_of :author

  def self.important
    where(important: true)
  end

  def self.not_important
    where(important: false)
  end
end
