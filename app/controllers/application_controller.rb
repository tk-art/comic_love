class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[home about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name profile image])
  end
end
