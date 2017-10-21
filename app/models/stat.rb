class Stat
  include ActiveModel::Model

  attr_accessor :total_win, :win_ratio, :match_played, :mvp, :score, :rebound, :block, :steal, :assist, :looseball
end
