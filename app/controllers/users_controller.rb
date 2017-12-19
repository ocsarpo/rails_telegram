class UsersController < ApplicationController
  def signup
    #form으로 가입 정보 받아 /register에 넘김
  end

  def register
    User.create(
      email: params[:email],
      password: params[:password]
    )
    redirect_to '/'
  end
  def login
    # 폼으로 로그인 정보 받아 login_session로 보낸다
  end
  def logout
    session.clear
    redirect_to '/'
  end

  def login_session
    user = User.find_by(email: params[:email])
    @message = ""
    if user
      if user.password == params[:password]
        @message ="로그인 성공"
        session[:user_id] = user.id
      elsif
        @message ="비번확인"
        redirect_to '/users/login'
      end
    else
      @message ="email 없음"
      redirect_to '/users/signup'
    end
    redirect_to '/'
  end
end
