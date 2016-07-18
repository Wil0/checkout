require 'promotion'

describe Promotion do
  subject(:promotion) {described_class.new()}

  describe '#initialize' do
    it 'starts with a minimun amount spent to get a discount' do
      expect(promotion.amount_discount).to eq 60
    end

    it 'starts with a discount percentage' do
      expect(promotion.discount).to eq 0.1
    end

    it 'starts with a minimun quantity to get a discount' do
      expect(promotion.qtty_discount).to eq 1
    end

    it 'starts with a special offer' do
      expect(promotion.special_offer).to eq ({code: '001', name: 'Lavender', price: 8.50})
    end
  end

  describe '#discount_per_amount' do
    context 'when a customer spends over £60' do
      it "the customer gets 10% off of their purchase" do
        total_price = 60.01
        expect(promotion.discount_per_amount(total_price)).to eq 6.00
      end
    end

    context 'when a customer spends £60 or less' do
      it 'the customer does not get a discount' do
        total_price = 60
        expect(promotion.discount_per_amount(total_price)).to eq 0
      end
    end
  end

  describe '#new_discount_price' do

    context 'when a customer buys more than one item of the same product' do
      it "the price per item is reduced" do
        items = [{code: '001', name: 'Lavender', price: 9.25},
                 {code: '001', name: 'Lavender', price: 9.25},
                 {code: '002', name: 'T-shirt', price: 45.00}
               ]
        special_offer = {code: '001', name: 'Lavender', price: 9.25}
        item_price = 9.25
        expect(promotion.new_discount_price(items, special_offer)).to eq 8.50
      end
    end

    context 'when a customer buys one item of the same product' do
      it 'the price does not change' do
        items = [{code: '001', name: 'Lavender', price: 9.25},
                 {code: '002', name: 'Cufflinks', price: 19.95},
                 {code: '003', name: 'T-shirt', price: 45.00}
               ]
        special_offer = {code: '001', name: 'Lavender', price: 9.25}
        item_price =  9.25
        expect(promotion.new_discount_price(items, special_offer)).to eq 9.25
      end
    end
  end
end
