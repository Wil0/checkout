require 'promotion'

describe Promotion do
  subject(:promotion) {described_class.new}

  describe '#discount' do
    context 'when a customer spends over £60' do
      it "the customer gets #{(described_class::DISCOUNT * 100).round}% off of their purchase" do
        total_price = 61
        expect(promotion.discount(total_price)).to eq 6.1
      end
    end

    context 'when a customer spends £60 or less' do
      it 'the customer does not get a discount' do
        total_price = 60
        expect(promotion.discount(total_price)).to eq 0
      end
    end
  end

  describe '#new_discount_price' do

    context 'when a customer buys more than one item of the same product' do
      it "the price per item is reduced" do
        items = ['001', '003', '001']
        item_price = 9.25
        product = '001'
        expect(promotion.new_discount_price(items, product)).to eq 8.50
      end
    end

    context 'when a customer buys one item of the same product' do
      it 'the price does not change' do
        items = ['001', '002', '003']
        product = '001'
        item_price =  9.25
        expect(promotion.new_discount_price(items, product)).to eq 9.25
      end
    end
  end
end
