class Promotion

  NORMAL_PRICE = 9.25
  DISCOUNT_PRICE = 8.50

  attr_reader :amount_discount, :discount, :qtty_discount

  def initialize(amount_discount = 60, discount = 0.1, qtty_discount = 1)
    @amount_discount = amount_discount
    @discount = discount
    @qtty_discount = qtty_discount
  end


  def discount_per_amount(total)
    get_discount?(total) ? (total *  @discount).round(2) : 0
  end

  def new_discount_price(items, product)
    quantity_of_items(items)[product] > @qtty_discount ?
    (DISCOUNT_PRICE) : (NORMAL_PRICE)
  end

  private

  def get_discount?(total)
    total > @amount_discount
  end

  def quantity_of_items(items)
    b= Hash.new(0)
    items.each { |i| b[i] += 1 }
    b
  end
end
