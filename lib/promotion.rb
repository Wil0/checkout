class Promotion

  attr_reader :amount_discount, :discount, :qtty_discount, :special_offer

  def initialize(amount_discount = 60, discount = 0.1, qtty_discount = 1,
                 special_offer = {code: "001", name: "Lavender", price: 8.50})
    @amount_discount = amount_discount
    @discount = discount
    @qtty_discount = qtty_discount
    @special_offer = special_offer
  end
end
