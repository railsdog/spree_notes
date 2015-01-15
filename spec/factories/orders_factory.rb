FactoryGirl.define do
  factory :order_with_notes, parent: :completed_order_with_totals do
    after(:create) do |order|
      3.times { create(:note, noteable: order) }
      2.times { create(:important_note, noteable: order) }
    end
  end

  factory :order_with_unimportant_notes, parent: :completed_order_with_totals do
    after(:create) do |order|
      5.times { create(:note, noteable: order) }
    end
  end
end
