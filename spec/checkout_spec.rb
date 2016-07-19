require 'checkout'
describe Checkout do
  subject(:checkout) {described_class.new(promotion)}

  let (:promotion) { double :promotion, amount_discount: 60,
                      discount: 0.1,
                      qtty_discount: 1,
                      special_offer: {
                                      code: "001",
                                      name: "Lavender",
                                      price: 8.50
                                    }
                    }
  let(:item1) { {code: '001', name: 'Lavender', price: 9.25} }
  let(:item2) { {code: '002', name: 'Cufflinks', price: 19.95} }
  let(:item3) { {code: '003', name: 'T-shirt', price: 45.00} }


  describe '#initialize' do
    it 'starts with a empty basket' do
      expect(checkout.pre_basket).to eq []
    end

    it 'starts with a promotion' do
      expect(checkout.promotion).to eq promotion
    end
  end

  describe '#basket' do
    it 'shows the purchased items' do
      checkout.scan(item1)
      checkout.scan(item2)
      expect(checkout.basket).to eq 'Basket: 001,002'
    end
  end

  describe '#scan' do
    it 'adds scaned items to the pre_basket' do
      checkout.scan(item1)
      checkout.scan(item2)
      expect(checkout.pre_basket).to eq [item1, item2]
    end
  end

  describe '#apply_qtty_discount' do
    context 'when the customer buys two or more items of the same product' do
      it 'updates the price of the item' do
        2.times { checkout.scan(item1) }
        checkout.scan(item2)
        new_price = promotion.special_offer[:price]
        expect{ checkout.apply_qtty_discount }.to change{item1[:price]}.from(item1[:price]).to(new_price)
      end
    end

    context 'when the customer buys one item of the same product' do
      it 'does not update the price of the item' do
        checkout.scan(item1)
        checkout.scan(item2)
        expect{ checkout.apply_qtty_discount }.not_to change{item1[:price]}
      end
    end
  end

  describe '#discount_per_amount' do
    context 'when a customer spends over £60' do
      it "the customer gets 10% off of their purchase" do
        checkout.scan(item1)
        checkout.scan(item2)
        checkout.scan(item3)
        expect(checkout.discount_per_amount).to eq 7.42
      end
    end

    context 'when a customer spends £60 or less' do
      it 'the customer does not get a discount' do
        checkout.scan(item1)
        checkout.scan(item2)
        expect(checkout.discount_per_amount).to eq 0
      end
    end
  end

  describe '#subtotal' do
    it 'calculates the subtotal of the items in the pre_pre_basket' do
      2.times do checkout.scan(item1)
      end
      checkout.scan(item2)
      checkout.apply_qtty_discount
      expect(checkout.subtotal).to eq 36.95
    end
  end

  describe '#total' do
    before :each do
      checkout.scan(item1)
      checkout.scan(item2)
    end
    context 'when a customer spends more than £60' do
      it 'gives the total amount after applying discount' do
        checkout.scan(item3)
        expect(checkout.total).to eq 'Totalpriceexpected: £66.78'
      end
    end

    context 'when a customer spends £60 or less' do
      it 'gives the total amount without applying discount' do
        expect(checkout.total).to eq 'Totalpriceexpected: £29.20'
      end
    end
  end
end
