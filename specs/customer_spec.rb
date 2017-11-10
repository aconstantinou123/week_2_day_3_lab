require('minitest/autorun')
require('minitest/rg')
require_relative('../pub.rb')
require_relative('../drink.rb')
require_relative('../customer.rb')
require_relative('../food.rb')

class TestCustomer < MiniTest::Test

  def setup

    @food1 = Food.new("Crisps", 0.50, 10, 5)
    @food2 = Food.new("Peanuts", 5.00, 20, 5)
    @food3 = Food.new("Pork Scratchings", 2.00, 30, 5)

    @drink1 = Drink.new("Vodka", 4.50, 40, 5)
    @drink2 = Drink.new("Beer", 5.00, 5, 5)
    @drink3 = Drink.new("Wine", 8.50, 25, 0)

    @pub = Pub.new("The King's Head", 0.0, [@drink1, @drink2, @drink3], [@food1, @food2, @food3])

    @customer = Customer.new("Alan", 20.00, 21, 0)
    @customer2 = Customer.new("Bob", 3.00, 15, 0)
    @customer3 = Customer.new("Chris", 3.00, 15, 60)


  end

  def test_customer_name
    assert_equal("Alan", @customer.name)
  end

  def test_customer_wallet
    assert_equal(20.00, @customer.wallet)
  end

  def test_customer_is_too_drunk__buy_drink
    assert_equal(4.50, @customer.buy_drink(@pub, @drink1))
    assert_equal(9.00, @customer.buy_drink(@pub, @drink1))
    assert_equal("Customer is too drunk", @customer.buy_drink(@pub, @drink1))
  end

  def test_customer_is_too_young__buy_drink
    assert_equal("Customer is too young", @customer2.buy_drink(@pub, @drink1))
  end

  def test_remove_money_from_wallet
    assert_equal(15.50, @customer.remove_money(@drink1))
  end

  def test_customer_elligible__true
    assert_equal(true, @customer.check_age(@drink1))
  end

  def test_customer_elligible__false
    assert_equal(false, @customer2.check_age(@drink1))
  end

  def test_customer_has_enough_money
    assert_equal(true, @customer.check_money(@drink1))
  end

  def test_drunkeness__drunk
    assert_equal(false, @customer3.check_drunkeness(@drink1))
  end

  def test_drunkeness__sober
    assert_equal(true, @customer.check_drunkeness(@drink1))
  end

  def test_buy_food_success
    @customer3.buy_food(@food3)
    assert_equal(30, @customer3.drunkeness)
  end

  def test_buy_food_fail
    @customer3.buy_food(@food2)
    assert_equal("Customer can't afford food", @customer3.buy_food(@food2))
  end

  def test_check_stock_out_of_stock
    @customer.check_stock(@drink3)
    assert_equal("Out of stock", @customer.check_stock(@drink3))
  end

  def test_check_stock_success
    @customer.check_stock(@drink2)
    assert_equal(4, @drink2.stock)
  end
end
