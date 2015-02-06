class Party < ActiveRecord::Base

  has_many :orders
  has_many :meals, through: :orders


  def total
    total = 0
    orders = self.orders
    orders.each do |order|
      total += order.meal.price.to_i * order.quantity.to_i
    end
    total
  end

end
