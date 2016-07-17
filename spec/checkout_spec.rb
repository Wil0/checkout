require 'checkout'
describe Checkout do
  subject(:checkout) {described_class.new()}

  describe '#initialize' do
    it 'starts with a empty basket' do
      expect(checkout.basket).to eq []
    end
    
  end
  describe '#scan' do
    it 'adds scaned item to the basket' do
      item = {code: '001',
              name: 'Lavender',
              price: 9.25}
      checkout.scan(item)
      expect(checkout.basket).to eq [item]
    end
  end
end
