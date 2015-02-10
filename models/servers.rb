class Server < ActiveRecord::Base

  has_many :parties

  def todays_tips
    tips = 0.00
    today = Date.today.to_s
    tomorrow = (Date.today+1).to_s
    sql = "server_id = #{self.id} AND created_at BETWEEN '" + today + " 05:00:00' AND '" + tomorrow + " 04:59:59'"
    parties = Party.where(sql)
      parties.each do |party|
        tips += party.tip
      end
    return tips
  end

end
