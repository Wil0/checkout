# Check-out
This check­out can scan items in any order,  accepts different promotions you want to use during the checkout and gives a list of items in the basket and their total amount.

## Getting Started

### Prerequisities

1) This program uses **Ruby 2.3.0**
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

The store has a list of products as per below:
­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­
| Product code  | Name                 |  Price  |
| ------------- |:-------------:       |  -----: |
| 001           | |Lavenderheart       |  £9.25  |
| 002           | Personalisedcufflinks| £45.00  |
| 003           | Kids T-­shirt         | £19.95  |

The marketing team wants to offer promotions as an incentive for the customers to purchase these items.

If you spend over £60, then you get 10% off of your purchase. If you buy 2 or more lavender hearts then the
price drops to £8.50.

The check­out can scan items in any order, and because the promotions will change, it needs to be flexible
regarding the promotional rules.

The interface to the checkout looks like this (shown in Ruby):
co=Checkout.new​(promotional_rules)
co.scan​(item)
co.scan​(item)
price=co.total

The final result is:

```
A customer buys a item of each product
Basket:001,002,003
Totalpriceexpected:£66.78

A customer buys two items of product 001 and one of product 002
Basket:001,003,001
Totalpriceexpected:£36.95

A customer buys two items of product 001 and one of both product 002 and product 003
Basket:001,002,001,003
Totalpriceexpected:£73.76
```

## Running the tests

Run ``` $ rspec```
