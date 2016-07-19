class Promotion

  attr_reader :amount_discount, :discount, :qtty_discount, :special_offer

  def initialize(args = {})
    args = {
            amount_discount: 60,
            discount: 0.1,
            qtty_discount: 1,
            special_offer:{
                            code: "001",
                            name: "Lavender",
                            price: 8.50
                          }
            }.merge(args)

    @amount_discount = args[:amount_discount]
    @discount = args[:discount]
    @qtty_discount = args[:qtty_discount]
    @special_offer = args[:special_offer]
  end
end
