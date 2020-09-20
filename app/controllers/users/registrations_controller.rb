class Users::RegistrationsController < Devise::RegistrationsController
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
end
