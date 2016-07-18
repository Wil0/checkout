class Promotion

  attr_reader :amount_discount, :discount, :qtty_discount, :special_offer

  def initialize(amount_discount = 60, discount = 0.1, qtty_discount = 1,
                 special_offer = {code: "001", name: "Lavender", price: 8.50})
    @amount_discount = amount_discount
    @discount = discount
    @qtty_discount = qtty_discount
    @special_offer = special_offer
  end


  def discount_per_amount(total)
    get_discount?(total) ? (total *  @discount).round(2) : 0
  end

  def new_discount_price(items, special_offer)
    if quantity_of_each_item(items)[special_offer] > @qtty_discount
      @special_offer[:price]
    end
  end

  def quantity_of_each_item(items)
    b= Hash.new(0)
    items.map{ |i| b[i] += 1 }
    b
  end

  private

  def get_discount?(total)
    total > @amount_discount
  end

end
