  class Checkout

    attr_reader :pre_basket, :promotion

    def initialize(promotional_rules)
      @promotion = promotional_rules
      @pre_basket = []
    end

    def scan(item)
      @pre_basket << item
    end

    def basket
      'Basket: ' + @pre_basket.map {|item| item[:code]}.join(',')
    end

    def quantity_discount
      offer = promotion.special_offer
      q = promotion.qtty_discount
      @pre_basket.map do |item|
        if item[:code] == offer[:code] && quantity[item] > q
          item[:price] = offer[:price]
        end
      end
      @pre_basket
    end

    def discount_total_amount
      get_discount? ? (subtotal *  promotion.discount).round(2) : 0
    end


    def subtotal
      quantity_discount
      @pre_basket.map{|item| item[:price]}.reduce(:+)
    end

    def total
      "Total price expected: £#{"%.2f" % (subtotal - discount_total_amount)}"
    end

    private

    def quantity
      b= Hash.new(0)
      @pre_basket.map{ |i| b[i] += 1 }
      b
    end

    def get_discount?
      subtotal > promotion.amount_discount
    end
end
