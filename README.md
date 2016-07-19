# Checkout
This check­out can scan items in any order,  accepts different promotions you want to use during the check out and gives a list of items in the basket and their total amount.

## Getting Started

### Prerequisities

1)
```
$ git clone git@github.com:Wil0/checkout.git
$ cd checkout
```

2) This project uses **Ruby 2.3.0**
* Check if your version is 2.3.0
```
$ ruby -v
```

* If it is not, check if you have this ruby version installed ```$ rvm list```
* If
 * It is installed, ```$ rvm use 2.3.0```
 * Otherwise install it ```$ rvm install 2.3.0``` and use it as shown before


 ### Installing

Run ```$ bundle install```

## How to use it

### Overview

The store has a list of products as per below:

| Product code  | Name                  |  Price  |
| ------------- |:-------------:        |  -----: |
| 001           | Lavender heart         |  £9.25  |
| 002           | Personalised cufflinks | £45.00  |
| 003           | Kids T-­shirt         | £19.95  |

In order to offer promotions as an incentive for the customers to purchase these items, promotional rules can be used at check out.

Promotional rules are set by default and include:
* Amount spent to get a discount
* Discount in percentage
* Quantity to buy of a product to get a discount in the price of the product
* Product in offer

```
Promotion.new
=> <Promotion:  @amount_discount=60, @discount=0.1, @qtty_discount=1, @special_offer={:code=>"001", :name=>"Lavender", :price=>8.5}>
```

The rules can also be changed in order to set a new promotion

```
Promotion.new(50, 0.2, 1)
=> <Promotion: @amount_discount=50, @discount=0.2, @qtty_discount=1, @special_offer={:code=>"001", :name=>"Lavender", :price=>8.5}>

Promotion.new(100, 0.05, 2, {code: '003', name:' Personalised cufflinks', price:14.95})
=> <Promotion: @amount_discount=100, @discount=0.05, @qtty_discount=2, @special_offer={:code=>"003", :name=>" Personalised cufflinks", :price=>14.95}>
```

### Give it a go

#### I) The easy way

1) Install PRY if you don't have it yet
```
$ gem install pry
```

2) Then run ```$ ruby checkout_init.rb```

3) Go to the final step

#### II) The not so easy way

1) Go to the command line and open up your favourite REPL.

2) Require '/lib/ckeckout.rb' and './lib/promotion.rb'.

3) Create an instance of both classes and require promotion as a parameter of checkout.

4) Create the below three items or more if you feel adventurous! Items are in the final step.

#### The Final Step

Either way will lead you to this point.

Assuming the available items can be represented like:
```
item1 = {code: '001', name: 'Lavender', price: 9.25}
item2 = {code: '002', name: 'T-shirt', price: 45.00}
item3 = {code: '003', name: 'Cufflinks', price: 19.95}
```
The checkout can scan items in any order and give the total amount to pay after discounts -if any of them apply.

```
co.scan​(item2)
co.scan​(item3)
co.scan​(item1)
co.basket
=> "Basket: 003,001,002"
co.total
=> "Total price expected: £66.78"
```

Several example of the final result are:

```
A customer buys a item of each product
Basket:001,002,003
Total price expected:£66.78

A customer buys two items of product 001 and one of product 002
Basket:001,003,001
Total price expected:£36.95

A customer buys two items of product 001 and one of both product 002 and product 003
Basket:001,002,001,003
Total price expected:£73.76
```

## Running the tests

Running ```$ coveralls report``` will show coverage tests

```
 * lib/checkout.rb => 100%
  * lib/promotion.rb => 100%
  * spec/checkout_spec.rb => 100%
  * spec/promotion_spec.rb => 100%
  ```
  

Running ``` $ rspec``` should show you the below:

![Tests](https://cloud.githubusercontent.com/assets/16989462/16946474/9e631c10-4da1-11e6-9f1c-e1e5bdef6747.png)
