class MessagesController < ApplicationController
  def index
  end

  def send_msg
    url = "https://api.telegram.org/bot"
    token ="Your t-Token"
    res = HTTParty.get("#{url}#{token}/getUpdates")
    hash = JSON.parse(res.body)
    chat_id =  hash["result"][0]["message"]["chat"]["id"]
    msg = URI.encode(params[:msg])

    HTTParty.get("#{url}#{token}/sendMessage?chat_id=#{chat_id}&text=#{msg}")
    redirect_to '/'
  end
end
