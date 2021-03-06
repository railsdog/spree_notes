Deface::Override.new(virtual_path: "spree/admin/users/edit",
                     name:         "add_spree_notes_to_user",
                     insert_after: "[data-hook='admin_user_edit_general_settings']",
                     partial:      "spree/admin/notes/edit_user_notes",
                     disabled:     false)

Deface::Override.new(virtual_path: "spree/admin/users/edit",
                     name:         "important_user_notes_flag",
                     insert_after: "[data-hook='admin_user_edit_form_header']",
                     partial:      "spree/admin/notes/important_user_notes_flag",
                     disabled:     false)
