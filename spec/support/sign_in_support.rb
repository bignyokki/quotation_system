module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in '社員番号', with: user.employee_number
    fill_in 'パスワード', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end