class Admins::SessionsController < Devise::SessionsController
  def new_guest
    admin = Admin.guest
    sign_in admin
    redirect_to root_path, notice: 'ゲスト管理者としてログインしました。'
  end
end