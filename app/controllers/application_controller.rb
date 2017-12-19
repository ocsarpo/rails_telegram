class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 전역에서 쓸 수 있는 함수를 만들자
  def current_user
    # 루비는 막줄을 자동리턴하니까. 사용자는 current_user.email 이케하면됨
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  
  # 모든 컨트롤러가 발동되기 전에
  # 유저가 접속되어 있는지 확인한다.
  def authorize #로그인 되었는지 판별
    redirect_to '/users/login' unless current_user
  end
end
