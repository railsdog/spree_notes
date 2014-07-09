module AuthenticationHelpers
  def stub_admin_login!(user)
    Spree::Admin::BaseController.any_instance.stub(:spree_current_user).and_return(user)
    Spree::Admin::BaseController.any_instance.stub(:current_spree_user).and_return(user)
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers, :type => :feature
end
