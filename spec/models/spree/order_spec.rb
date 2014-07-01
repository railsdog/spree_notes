require 'spec_helper'

describe Spree::Order do
  let(:order) { create(:order_with_notes) }

  it 'has notes' do
    expect(order.notes.length).to eq 5
  end
end
