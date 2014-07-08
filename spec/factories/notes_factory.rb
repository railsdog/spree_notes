FactoryGirl.define do
  factory :note, class: Spree::Note do
    body 'This is the body of the note'
    author :user

    factory :important_note do
      important true
    end
  end
end
