require 'checkout'
describe Checkout do
  subject(:checkout) {described_class.new(promotion)}

  let (:promotion) { double :promotion, discount_per_amount: 0,
                      special_offer: {code: "001", name: "Lavender", price: 8.50},
                      new_discount_price: [
                        {:code=>"001", :name=>"Lavender", :price=>9.25},
                        ['001', 8.50]
                      ],
                      quantity_of_each_item: [{:code=>"001", :name=>"Lavender", :price=>9.25}]
                    }

  describe '#initialize' do
    it 'starts with a empty basket' do
      expect(checkout.basket).to eq []
    end
  end

  describe '#scan' do
    it 'adds scaned item to the basket' do

      item = {code: '001', name: 'Lavender', price: 9.25}

      checkout.scan(item)
      expect(checkout.basket).to eq [item]
    end
  end

  describe '#apply_qtty_discount' do
    # before :each do
      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}
    # end

    it 'updates the price of the item if it qualifies for discount' do

        2.times do checkout.scan(item1)
        end
        checkout.scan(item2)
        expect{ checkout.apply_qtty_discount }.to change{item1[:price]}.from(9.25).to(8.50)
    end
    it 'does not update the price of the item if it does not qualify for discount' do
      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}
        checkout.scan(item1)
        checkout.scan(item2)
        expect{ checkout.apply_qtty_discount }.not_to change{item1[:price]}
    end
  end

  describe '#quantity' do
    it 'gives the quantity of each item in the basket' do
      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}
      checkout.scan(item1)
      checkout.scan(item2)
      q = {{:code=>"001", :name=>"Lavender", :price=>9.25}=>1, {:code=>"003", :name=>"Cufflinks", :price=>19.95}=>1}
      expect(checkout.quantity).to eq q
    end
  end

  describe '#subtotal' do
    it 'calculates the subtotal of the items in the basket' do

      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item1 = {code: '001', name: 'Lavender', price: 9.25}
      item2 = {code: '003', name: 'Cufflinks', price: 19.95}

      2.times do checkout.scan(item1)
      end
      checkout.scan(item2)
      checkout.apply_qtty_discount
      expect(checkout.subtotal).to eq 36.95
    end
  end

  describe '#total' do
    context 'when a customer spends more than £60' do
      let (:promotion) { double :promotion, discount_per_amount: 7.42,
                        special_offer: ['001', 8.50],
                        new_discount_price: [{:code=>"001", :name=>"Lavender", :price=>9.25},
                                             ['001', 8.50]
                                             ],
                        quantity_of_each_item: [{:code=>"001", :name=>"Lavender", :price=>9.25}]}
      it 'gives the total amount after applying discount' do
        item1 = {code: '001', name: 'Lavender', price: 9.25}
        item2 = {code: '003', name: 'Cufflinks', price: 19.95}
        item3 = {code: '002', name: 'T-shirt', price: 45.00}
        checkout.scan(item1)
        checkout.scan(item2)
        checkout.scan(item3)
        expect(checkout.total).to eq 66.78
      end
    end

    context 'when a customer does spend £60 or less' do
      it 'gives the total amount without applying discount' do
        item1 = {code: '001', name: 'Lavender', price: 9.25}
        item2 = {code: '003', name: 'Cufflinks', price: 19.95}
        checkout.scan(item1)
        checkout.scan(item2)
        expect(checkout.total).to eq 29.20
      end
    end
  end
end
