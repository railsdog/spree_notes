require 'spec_helper'

describe Spree::Note do
  let(:note) { create(:note) }

  it 'has an author' do
    expect(note.author).to_not be_blank
  end
end
