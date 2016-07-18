  class Checkout

    attr_reader :basket

    def initialize(promotion)
      @promotion = promotion
      @basket = []
    end

    def scan(item)
      @basket << item
      # p @promotion.new_discount_price(@basket, @promotion.special_offer)
    end

    def apply_qtty_discount
      offer = @promotion.special_offer
      @basket.map do |item|
        item[:price] = offer[:price] if item[:code] == offer[:code] && quantity[item] > 1
      end
    end

    def quantity
      b= Hash.new(0)
      @basket.map{ |i| b[i] += 1 }
       p b
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
