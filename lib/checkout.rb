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
      @basket.map do |item|
        item[:price] = offer[:price] if item[:code] == offer[:code] && quantity[item] > 1
      end
    end

    def discount_per_amount(subtotal)
      subtotal  = self.subtotal
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
      subtotal - discount_per_amount(subtotal)
    end
    def get_discount?
      p subtotal
      p @promotion.amount_discount
      subtotal > @promotion.amount_discount
    end

    private

end
