require 'spec_helper'

describe 'notes on edit admin order page' do
  before(:each) do
    admin_user = create(:admin_user)
    stub_admin_login! admin_user
  end

  context 'creating', js: true do
    let!(:order) { create(:completed_order_with_totals) }

    before(:each) do
      visit spree.edit_admin_order_path(order)
    end

    it 'does not show the create note form initially' do
      expect(find('.js-create-note-form', visible: false).visible?).to be_falsey
    end

    it 'shows the create note form after clicking the create note button' do
      within_fieldset 'admin_order_edit_notes' do
        click_button 'Create New Note'
      end
      expect(find('.js-create-note-form', visible: false).visible?).to be_truthy
    end

    it 'can successfully create an unimportant note' do
      note_body = "This is a new note #{rand(10)}"
      within_fieldset 'admin_order_edit_notes' do
        click_button 'Create New Note'
        fill_in 'Note', with: note_body
        click_button 'Save order note'
      end
      assert_flash_success 'Note saved'
      expect(find('.note:not(.important) .note-content')).to have_text note_body
    end

    it 'can successfully create an important note' do
      note_body = "This is a new note #{rand(10)}"
      within_fieldset 'admin_order_edit_notes' do
        click_button 'Create New Note'
        fill_in 'Note', with: note_body
        check 'note_important'
        click_button 'Save order note'
      end
      assert_flash_success 'Note saved'
      expect(find('.note.important .note-content')).to have_text note_body
    end
  end

  context 'listing order notes. An Order' do
    context 'with important notes' do
      let(:order) { create(:order_with_notes) }

      before(:each) do
        visit spree.edit_admin_order_path(order)
      end

      it 'lists important notes' do
        notes_on_page = page.all('.note.important')
        order.notes.important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'lists unimportant notes' do
        notes_on_page = page.all('.note:not(.important)')
        order.notes.not_important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'shows the important notes exist banner' do
        expect(find('.important-notes-banner')).to(
          have_link '', href: '#important_notes'
        )
      end
    end

    context 'with all unimportant notes' do
      let(:order) { create(:order_with_unimportant_notes) }
      before(:each) do
        visit spree.edit_admin_order_path(order)
      end

      it 'does not list any important notes' do
        expect(page.all('.note.important').size).to eq 0
      end

      it 'lists unimportant notes' do
        notes_on_page = page.all('.note:not(.important)')
        order.notes.not_important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'does not show the important notes exist banner' do
        expect(page).not_to have_css '.important-notes-banner'
      end
    end

    context 'with no notes' do
      let(:order) { create(:order) }
      before(:each) do
        visit spree.edit_admin_order_path(order)
      end

      it 'does not list any notes' do
        expect(page.all('.note').size).to eq 0
      end

      it 'does not show the important notes exist banner' do
        expect(page).not_to have_css '.important-notes-banner'
      end
    end
  end
end
