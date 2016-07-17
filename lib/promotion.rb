class Promotion

  AMOUNT_TO_GET_DISCOUNT = 60
  DISCOUNT = 0.1

  def discount(total)
    get_discount?(total) ? (total *  DISCOUNT).round(2) : 0
  end

  private

  def get_discount?(total)
    total > AMOUNT_TO_GET_DISCOUNT
  end
end
