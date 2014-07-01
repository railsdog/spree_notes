FactoryGirl.define do
  factory :order_with_notes, parent: :order do
    after(:create) do |order|
      5.times { create(:note, noteable: order) }
    end
  end
end
