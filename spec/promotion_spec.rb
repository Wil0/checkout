require 'promotion'

describe Promotion do
  subject(:promotion) {described_class.new(args)}

  let(:args) { {
          amount_discount: 60,
          discount: 0.1,
          qtty_discount: 1,
          special_offer:{
                          code: "001",
                          name: "Lavender",
                          price: 8.50
                        }
          } }

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
end
