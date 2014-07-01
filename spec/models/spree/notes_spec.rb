require 'spec_helper'

describe Spree::Note do
  let(:note) { create(:note) }

  it 'is a note' do
    expect(note.body).to_not be_blank
  end
end
