Deface::Override.new(virtual_path:  "spree/admin/orders/edit",
                     name:          "add_spree_notes_to_order",
                     insert_bottom: "[data-hook='admin_order_edit_form']",
                     partial:       "spree/admin/notes/edit_order_notes",
                     disabled:      false)

Deface::Override.new(virtual_path:  "spree/admin/orders/edit",
                     name:          "important_order_notes_flag",
                     insert_bottom: "[data-hook='admin_order_edit_header']",
                     partial:       "spree/admin/notes/important_order_notes_flag",
                     disabled:      false)
