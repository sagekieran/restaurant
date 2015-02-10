class Teble < ActiveRecord::Base

  has_many :parties

  def available?
    self.parties.each do |party|
      if party.paid == false
        return false
      end
    end
  end

end
