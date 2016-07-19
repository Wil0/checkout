require 'pry'
require './lib/checkout'
require './lib/promotion'

prom  = Promotion.new()
co = Checkout.new(prom)

item1 = {code: '001', name: 'Lavender', price: 9.25}
item2 = {code: '002', name: 'T-shirt', price: 45.00}
item3 = {code: '003', name: 'Cufflinks', price: 19.95}

binding.pry
