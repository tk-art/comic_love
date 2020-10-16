class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]

  def after_sign_up_path_for(_resource)
    flash[:notice] = '登録に成功しました！プロフィールを充実させませんか？'
    edit_user_registration_path
  end

  def after_update_path_for(_resource)
    flash[:notice] = 'プロフィールを変更しました！'
    user_path(current_user)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def check_guest
    redirect_to root_path, alert: 'ゲストユーザーの編集、削除はできません！' if resource.email == 'ta1.pioneer.t@gmail.com'
  end
end
