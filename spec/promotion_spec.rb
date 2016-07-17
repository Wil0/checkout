require 'promotion'

describe Promotion do
  subject(:promotion) {described_class.new}

  let(:checkout) {double :checkout}

  context 'when customer spends over £60' do
    it "customer gets #{(described_class::DISCOUNT * 100).round}% off of your purchase" do
      total_price = 61
      allow(checkout).to receive(:total).and_return total_price
      expect(promotion.discount(total_price)).to eq 6.1
    end
  end
  context 'when customer spends £60 or less' do
    it 'customer does not get a discount' do
      total_price = 60
      allow(checkout).to receive(:total).and_return total_price
      expect(promotion.discount(total_price)).to eq 0
    end
  end
end
