class Meal < ActiveRecord::Base

  has_many :orders
  has_many :parties, through: :orders

  def self.check(name)
    Meal.all.each do |meal|
      if meal.name == name
        return false
      end
    end
  end

end
