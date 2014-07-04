class Spree::Admin::NotesController < Spree::Admin::BaseController

  before_filter :load_noteable

  def create
    @note = Spree::Note.new(note_params)
    @note.noteable = @noteable
    @note.author = try_spree_current_user.email
    @note.save

    flash[:success] = "Note Saved"
    redirect_to :back
  end

  protected

  def note_params
    params.require(:note).permit(:body, :important)
  end

  def load_noteable
    allowed_noteables = %w(user order)
    which = params.keys.map{|k| k.split('_').first }.find do |key|
      allowed_noteables.include? key
    end
    @noteable_klass = if which == "user"
      Spree.user_class
    else
      ("Spree::" + which.capitalize).constantize
    end
    @noteable = if @noteable_klass == Spree::Order
      Spree::Order.includes(:notes).find_by_number!(params["#{which}_id"])  
    else
      @noteable_klass.find(params["#{which}_id"])
    end
  end
end
