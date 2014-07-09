require 'spec_helper'

describe 'notes on edit admin user page' do
  before(:each) do
    admin_user = create(:admin_user)
    stub_admin_login! admin_user
  end

  context 'creating', js: true do
    let!(:user) { create(:user) }

    before(:each) do
      visit spree.edit_admin_user_path(user)
    end

    it 'does not show the create note form initially' do
      expect(find('.js-create-note-form', visible: false).visible?).to be_false
    end

    it 'shows the create note form after clicking the create note button' do
      within_fieldset 'admin_user_edit_notes' do
        click_button 'Create New Note'
      end
      expect(find('.js-create-note-form', visible: false).visible?).to be_true
    end

    it 'can successfully create an unimportant note' do
      note_body = "This is a new note #{rand(10).to_s}"
      within_fieldset 'admin_user_edit_notes' do
        click_button 'Create New Note'
        fill_in 'Note', with: note_body
        click_button 'Save user note'
      end
      assert_flash_success 'Note Saved'
      expect(find('.note:not(.important) .note-content')).to have_text note_body
    end

    it 'can successfully create an important note' do
      note_body = "This is a new note #{rand(10).to_s}"
      within_fieldset 'admin_user_edit_notes' do
        click_button 'Create New Note'
        fill_in 'Note', with: note_body
        check 'note_important'
        click_button 'Save user note'
      end
      assert_flash_success 'Note Saved'
      expect(find('.note.important .note-content')).to have_text note_body
    end
  end

  context 'listing user notes. A User' do
    context 'with important user notes' do
      let(:user) { create(:user_with_notes) }
      before(:each) do
        visit spree.edit_admin_user_path(user)
      end

      it 'lists important notes' do
        notes_on_page = page.all('.note.important')
        user.notes.important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'lists unimportant notes' do
        notes_on_page = page.all('.note:not(.important)')
        user.notes.not_important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'shows the important notes exist banner' do
        expect(find('.important-notes-banner')).to have_link '', href: '#important_notes'
      end
    end

    context 'with all unimportant user notes' do
      let(:user) { create(:user_with_unimportant_notes) }
      before(:each) do
        visit spree.edit_admin_user_path(user)
      end

      it 'does not list any important notes' do
        expect(page.all('.note.important').size).to eq 0
      end

      it 'lists unimportant notes' do
        notes_on_page = page.all('.note:not(.important)')
        user.notes.not_important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'does not show the important notes exist banner' do
        expect(page).not_to have_css '.important-notes-banner'
      end
    end

    context 'with no user notes' do
      let(:user) { create(:user) }
      before(:each) do
        visit spree.edit_admin_user_path(user)
      end

      it 'does not list any notes' do
        expect(page.all('.note').size).to eq 0
      end

      it 'does not show the important notes exist banner' do
        expect(page).not_to have_css '.important-notes-banner'
      end
    end
  end

  context 'listing notes for a users\' orders. A User' do
    context 'with important notes on orders' do
      let(:user) do
        user = create(:user)
        3.times { order = create(:order_with_notes, user: user) }
        user
      end

      before(:each) do
        visit spree.edit_admin_user_path(user)
      end

      it 'lists all the important notes from the users\' orders' do
        notes_on_page = page.all('.note.important')
        expect(notes_on_page.size).to eq Spree::Note.important.count
      end

      it 'lists all the unimportant notes from the users\' orders' do
        notes_on_page = page.all('.note:not(.important)')
        expect(notes_on_page.size).to eq Spree::Note.not_important.count
      end

      it 'shows the important notes exist banner' do
        expect(find('.important-notes-banner')).to have_link '', href: '#important_notes'
      end
    end

    context 'with a single order with only unimportant notes' do
      let!(:user)  { create(:user) }
      let!(:order) { create(:order_with_unimportant_notes, user: user) }

      before(:each) do
        visit spree.edit_admin_user_path(user)
      end

      it 'does not list any important notes from the users\' order' do
        notes_on_page = page.all('.note.important')
        expect(notes_on_page.size).to eq 0
      end

      it 'lists all the unimportant notes from the users\' order' do
        notes_on_page = page.all('.note:not(.important)')
        order.notes.not_important.each_with_index do |note, index|
          expect(notes_on_page[index]).to have_text note.body
        end
      end

      it 'displays links the notes\' order' do
        page.all('.note') do |note|
          expect(note).to have_link order.number
        end
      end

      it 'does not show the important notes exist banner' do
        expect(page).not_to have_css '.important-notes-banner'
      end
    end
  end
end
