  class Checkout

    attr_reader :basket

    def initialize(promotion)
      @promotion = promotion
      @basket = []
    end

    def scan(item)
      @basket << item
    end

    def apply_qtty_discount
      offer = @promotion.special_offer
      basket = @basket.map do |item|
        item[:price] = offer[:price] if item[:code] == offer[:code] && quantity[item] > 1
      end
      @basket
    end

    def discount_per_amount
      get_discount? ? (subtotal *  @promotion.discount).round(2) : 0
    end

    def quantity
      b= Hash.new(0)
      @basket.map{ |i| b[i] += 1 }
      b
    end

    def subtotal
      @basket.map{|item| item[:price]}.reduce(:+)
    end

    def total
      subtotal - discount_per_amount
    end

    private

    def get_discount?
      subtotal > @promotion.amount_discount
    end
end
