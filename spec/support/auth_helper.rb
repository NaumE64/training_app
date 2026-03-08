module AuthHelper
  def login_user(user)
    allow_any_instance_of(ApplicationController).to receive(:user_logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :request
end