class MessagesController < ApplicationController
  # before_action "함수명"
  before_action :authorize
  # before_action을 통해서 MessagesController가 발동되기 전에 로그인으로 보내버렷!

  def index
       # 보낸 메시지 출력
       @messages = Message.all.reverse
  end

  def send_msg
    # 보낸 메시지 저장
    Message.create(
      user_id: session[:user_id],
      content: params[:msg]
    )
    url = "https://api.telegram.org/bot"
    token = Rails.application.secrets.telegram_token
    res = HTTParty.get("#{url}#{token}/getUpdates")
    hash = JSON.parse(res.body)
    chat_id =  hash["result"][0]["message"]["chat"]["id"]
    # msg = URI.encode("#{User.find(session[:user_id]).email} : "+params[:msg])
    msg = URI.encode("#{current_user.email} : "+params[:msg])


    HTTParty.get("#{url}#{token}/sendMessage?chat_id=#{chat_id}&text=#{msg}")
    redirect_to '/'
  end
end
