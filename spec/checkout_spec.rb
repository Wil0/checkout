require 'checkout'
describe Checkout do
  subject(:checkout) {described_class.new(promotion)}

  let (:promotion) { double :promotion, discount_per_amount: 0}

  describe '#initialize' do
    it 'starts with a empty basket' do
      expect(checkout.basket).to eq []
    end
  end

  describe '#scan' do
    it 'adds scaned item to the basket' do

      item = {code: '001', name: 'Lavender',price: 9.25}

      checkout.scan(item)
      expect(checkout.basket).to eq [item]
    end
  end

  describe '#subtotal' do

    it 'calculates the subtotal of the items in the basket' do

      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}

      checkout.scan(item1)
      checkout.scan(item2)
      expect(checkout.subtotal).to eq 29.20
    end
  end

  describe '#total' do

    it 'gives the total amount after applying discount' do

      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}
      checkout.scan(item1)
      checkout.scan(item2)
      checkout.subtotal
      expect(checkout.total).to eq 29.20
    end
  end
end
