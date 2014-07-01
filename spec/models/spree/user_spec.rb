require 'spec_helper'

describe Spree.user_class do
  let(:user) { create(:user_with_notes) }

  it 'has notes' do
    expect(user.notes.length).to eq 5
  end
end
