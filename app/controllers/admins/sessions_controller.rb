class Admins::SessionsController < Devise::SessionsController
	#ゲストログイン
  def new_guest
    admin = Admin.guest
    sign_in admin
    redirect_to admin_root_path, notice: 'ゲスト管理者としてログインしました。'
  end
end