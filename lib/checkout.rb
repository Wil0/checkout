  class Checkout

    attr_reader :basket, :promotion

    def initialize(promotional_rules)
      @promotion = promotional_rules
      @basket = []
    end

    def scan(item)
      @basket << item
    end

    def apply_qtty_discount
      offer = promotion.special_offer
      q = promotion.qtty_discount
      @basket.map do |item|
        if item[:code] == offer[:code] && quantity[item] > q
          item[:price] = offer[:price]
        end
      end
      @basket
    end

    def discount_per_amount
      get_discount? ? (subtotal *  promotion.discount).round(2) : 0
    end


    def subtotal
      apply_qtty_discount
      @basket.map{|item| item[:price]}.reduce(:+)
    end

    def total
      "£#{"%.2f" % (subtotal - discount_per_amount)}"
    end

    def print_receipt
       p basket
    end

    private

    def quantity
      b= Hash.new(0)
      @basket.map{ |i| b[i] += 1 }
      b
    end

    def get_discount?
      subtotal > promotion.amount_discount
    end
end
