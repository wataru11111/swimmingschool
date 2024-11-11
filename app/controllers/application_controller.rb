# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # 新規登録およびログイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      sign_out(:customer) # 他のリソース（顧客）がログインしている場合はサインアウト
      admin_path          # 管理者の場合は管理者トップページにリダイレクト
    elsif resource.is_a?(Customer)
      customers_show_path # 顧客の場合はマイページにリダイレクト
    else
      super               # それ以外の場合はデフォルトのリダイレクト先
    end
  end

  # ログアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path # 管理者ログアウト後のリダイレクト先
    else
      root_path             # 顧客ログアウト後のリダイレクト先
    end
  end
end
