class Customer

  attr_accessor :name, :wallet, :age, :drunkeness

  def initialize(name, wallet, age, drunkeness)

    @name = name
    @wallet = wallet
    @age = age
    @drunkeness = drunkeness

  end

  def check_age(drink)
    if age >= 18
      return true
    else
      return false
    end
  end

  def check_money(drink)
    if wallet >= drink.price
      return true
    else
      return false
    end
  end

  def check_drunkeness(drink)
    if @drunkeness <= 50
      return true
    else
      return false
    end
  end

  def check_stock(drink)
    if drink.stock >= 1
        drink.stock -= 1
      return true
    else
      return "Out of stock"
    end
  end

  def remove_money(drink)
    if @wallet >= drink.price
      @wallet -= drink.price
      return @wallet
    else
      return "Customer doesn't have enough money"
    end
  end

  def buy_drink(pub, drink)
    if check_age(drink) == true && check_money(drink) == true &&
    check_drunkeness(drink) == true &&
    check_stock(drink) == true
      pub.till += drink.price
      remove_money(drink)
      @drunkeness += drink.alcohol_level
      return pub.till
        elsif check_age(drink) == false
      return "Customer is too young"
        elsif check_drunkeness(drink) == false
      return "Customer is too drunk"
        else
      return "Customer can't afford drink"
    end

  end

  def buy_food(food)
    if check_money(food) == true && check_stock(food) == true
      remove_money(food)
      @drunkeness -= food.rejuv_level
    else
      return "Customer can't afford food"
    end
  end

end
