class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 認証成功→ユーザー情報ページにリダイレクト
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember_user
      redirect_to user
    else
      # 認証失敗→エラーメッセージの作成
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
    
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
