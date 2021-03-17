class ApplicationController < ActionController::Base
  # Basic認証
  before_action :basic_auth
  
  # :devise_controller?というdeviseのヘルパーメソッド名を指定
  # もしdeviseに関するコントローラーの処理であれば、そのときだけconfigure_permitted_parametersメソッドを実行するように設定
  # ifオプションを使用、値にメソッド名を指定することで、その戻り値がtrueであったときにのみ処理を実行するよう設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # sign_up（新規登録の処理）に対して、nicknameというキーのパラメーターを新たに許可する。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
