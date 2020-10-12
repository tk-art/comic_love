# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(_resource)
    root_url
  end

  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました！'
  end
end
