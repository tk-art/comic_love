module SessionHelpers
  def sign_up_with(name, email, password, confirmation)
    visit new_user_registration_path
    fill_in 'name', with: name
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password-confirmation', with: confirmation
    click_button '登録する'
  end

  def sign_in(email, password)
    visit new_user_session_path
    fill_in 'email', with: email
    fill_in 'password', with: password
    check   'ログインを記憶する'
    click_button 'ログイン'
  end
end
