class CreateSpreeNotes < ActiveRecord::Migration
  def change
    create_table :spree_notes do |t|
      t.references :noteable, polymorphic: true, index: true
      t.column :body, :text
      t.column :important, :boolean, default: false
      t.column :author, :string
      t.timestamps
    end
  end
end
