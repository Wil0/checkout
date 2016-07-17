class Promotion

  AMOUNT_TO_GET_DISCOUNT = 60
  DISCOUNT = 0.1
  QTTY_FOR_DISCOUNT = 1
  NORMAL_PRICE = 9.25
  DISCOUNT_PRICE = 8.50

  def discount(total)
    get_discount?(total) ? (total *  DISCOUNT).round(2) : 0
  end

  def new_discount_price(items, product)
    quantity_of_items(items)[product] > QTTY_FOR_DISCOUNT ?
    (DISCOUNT_PRICE) : (NORMAL_PRICE)
  end

  private

  def get_discount?(total)
    total > AMOUNT_TO_GET_DISCOUNT
  end

  def quantity_of_items(items)
    b= Hash.new(0)
    items.each { |i| b[i] += 1 }
    b
  end
end
