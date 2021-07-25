require 'date'

class User
  attr_reader :id
  def initialize(id, userId, wallet)
    @id = id
    @userId = userId
    @wallet = wallet
  end

  # User can deposit money into her wallet
  def deposit(money)
    wallet.balance += money
  end

  # User can withdraw money from her wallet def withdraw(money)
  def withdraw(money)
    curBalance = wallet.balance
    if curBalance > money
      wallet.balance = curBalance - money
      return true
    else
      return false
    end
  end

  # User can send money to another user
  def transfer(userId, dest, money)
    # search dest in system paltform
    unless dest
      puts "The user is not exist #{destId.name.to_s}"
    end
    return flase

    startBalance = self.wallet.balance
    if startBalance < money
      puts "Transfer amount is greater than users's balance"
    end
    return flase

    #User have the ability to transfer money
    destId.wallet.balance += money
    self.wallet.balance -= money

    transaction1 = new Transaction(self.name, dest.name, money, DateTime.now)
    return transaction1
  end


#Get the top N richest user
#Get total income and outcome of a special day
#User can see her wallet transactino history
class Wallet
  attr_reader :id
  attr_accessor :balance

  def initialize(id, balance)
    @id = id
    @balance = balance
  end

end

#require User start A
#require User dest B
#require transaction money : user minus to represent A->B; use B->A then positve number
#require date
class Transaction
  def initialize(start, dest, money, date)
    @start = start
    @dest = dest
    @money = money
    @date = date
  end
end

#define the relationship between user A and Wallet A in here
class System
  #hash1 user-> wallet
  #hash2 user-> transaction
  include Singleton

  @@userList = Hash.new
  @@usertoWallet = Hash.new
  @@usertoTransaction = Hash.new 

  def initialize()

  end

  def linkUserAndWallet(user, wallet)

  end

  def getWalletByUser(user)
    wallet = @@usertoWallet[:user]
  end


  def addUserToWallet(user, wallet)
    usertoWallet[:user] = wallet
  end

  def recordTransaction()

  end

  
  def getTopNRichestUser(n)

  end
end




def main()
  #1. Create Sysetm
  walletSystem = System.instance 
  
  #2. Create User
  
  #3. Create Wallet

end


end
