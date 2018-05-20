module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin) # Using factory girl as an example
    end
  end

  def login_user(user=nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user ||= FactoryBot.create(:user)
      sign_in user
    end
  end

  def logout_admin(user=nil)
    before(:each) do
      sign_out user
    end
  end
end