  class Checkout

    attr_reader :basket

    def initialize(promotion)
      @basket = []
      @promotion = promotion
    end

    def scan(item)
      @basket << item
    end

    def subtotal
      @basket.map{|item| item[:price]}.reduce(:+)
    end

    def total
      amount = self.subtotal
      discount = @promotion.discount_per_amount(amount)
      amount - discount
    end
  end
