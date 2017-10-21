class HomeController < ApplicationController
  def index
    @stat = Stat.new
  end

  def search
    @stat = Stat.new(stat_params)
    request_to_fsserver
    render :index
  end

  private

  def stat_params
    params.require(:stat).permit(:total_win, :win_ratio, :match_played, :mvp, :score, :rebound, :block, :steal, :assist, :looseball)
  end

  def request_to_fsserver
    uri = URI.parse('http://3on3rank.fsgames.com/rank')
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.set_form_data()

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    response = nil
    http.start { |h| response = h.request(request) }
    response.body.encode('UTF-8', 'Shift_JIS')

  rescue => e
    flash.now[:alert] = 'エラーが発生しました。'
  end
end
