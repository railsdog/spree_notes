FactoryGirl.define do
  factory :user_with_notes, parent: :user do
    after(:create) do |user|
      3.times { create(:note, noteable: user) }
      2.times { create(:important_note, noteable: user) }
    end
  end

  factory :user_with_unimportant_notes, parent: :user do
    after(:create) do |user|
      5.times { create(:note, noteable: user) }
    end
  end
end
