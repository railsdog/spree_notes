require 'spec_helper'

describe Spree::Note do
  context 'a valid note' do
    let(:note) { create(:note) }

    it 'has an author' do
      expect(note.author).to_not be_blank
    end

    it 'has a created_at time' do
      expect(note.created_at).to_not be_nil
    end
  end

  context 'creating a note' do
    it 'fails if there is no author specified' do
      note = Spree::Note.new
      expect{ note.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'succeeds if there is an author specified' do
      Spree::Note.create!(author: 'user@example.com')
      expect(Spree::Note.count).to eq 1
    end
  end

  context 'class methods' do
    before(:each) do
      3.times { |i| create(:note, created_at: Time.now - i.days) }
      4.times { |i| create(:important_note, created_at: Time.now + i.days) }
    end

    it '.important scope returns only important notes' do
      Spree::Note.important.each do |note|
        expect(note.important).to be_true
      end
    end

    it '.not_important scope returns only unimportant notes' do
      Spree::Note.not_important.each do |note|
        expect(note.important).to be_false
      end
    end

    context 'finders always return notes ordered' do
      it 'with important notes first primarily' do
        Spree::Note.all.each_cons(2) do |current_note, next_note|
          if current_note.important != next_note.important
            expect(next_note.important).to be_false
          end
        end
      end

      it 'recent first chronological secondly' do
        Spree::Note.all.each_cons(2) do |current_note, next_note|
          if current_note.important == next_note.important
            expect(current_note.created_at).to be >= next_note.created_at
          end
        end
      end
    end
  end
end
