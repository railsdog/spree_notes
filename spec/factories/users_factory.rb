FactoryGirl.define do
  factory :user_with_notes, parent: :user do
    after(:create) do |user|
      5.times { create(:note, noteable: user) }
    end
  end
end
