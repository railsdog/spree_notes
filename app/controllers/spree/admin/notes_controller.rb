class Spree::Admin::NotesController < Spree::Admin::BaseController
  before_action :load_noteable

  def create
    @note = Spree::Note.new(note_params)
    @note.noteable = @noteable
    @note.author = try_spree_current_user.email
    @note.save

    flash[:success] = 'Note saved'
    redirect_to request.referer.nil? ? admin_path : :back
  end

  protected

  def data_params
    [:body, :important]
  end

  def note_params
    params.require(:note).permit(data_params)
  end

  def allowed_noteables
    %w(user order)
  end

  def load_noteable
    which = params.keys.map { |k| k.split('_').first }.find do |key|
      allowed_noteables.include? key
    end
    @noteable = find_notable_data(which)
  end

  def find_notable_data(which)
    noteable_klass = find_notable_klass(which)
    @noteable = if noteable_klass == Spree::Order
                  Spree::Order.includes(:notes).
                               find_by_number!(params["#{which}_id"])
                else
                  noteable_klass.find(params["#{which}_id"])
                end
  end

  def find_notable_klass(which)
    if which == 'user'
      Spree.user_class
    else
      "Spree::#{which.capitalize}".constantize
    end
  end
end
