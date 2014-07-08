Spree::Admin::UsersController.class_eval do
  append_before_filter :load_user_orders, only: :edit

  private

  # Private: loads notes for the current user's orders with its parent order.
  # Avoids n+1 queries.
  #
  # adds @order_notes to the render context
  def load_user_orders
    user_order_ids = Spree::Order.where(user: @user).pluck(:id)
    @order_notes = Spree::Note.where(noteable_type: 'Spree::Order')
                              .where(noteable_id: user_order_ids)
                              .includes(:noteable)
                              .order(important: :desc, created_at: :desc)
  end
end
