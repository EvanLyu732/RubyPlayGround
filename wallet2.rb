require 'date'
require 'singleton'

class User
  attr_reader :userid, :userName

  def initialize(userid, userName, system) 
    @userid = userid
    @userName = userName
    @system = system
  end

  # wallet = system.new(nil,nil).getWalletByUser(self.class)

  # def self.getUserWallet(userid, system)
  # end

  # User can deposit money into her wallet
  def self.deposit()
    
  end

  # User can withdraw money from her wallet def withdraw(money)
  def self.withdraw()
  end

  # User can send money to another user
  def self.transfer(destUser)
  end
end


#Get the top N richest user
#Get total income and outcome of a special day
#User can see her wallet transactino history
class Wallet
  attr_reader :id
  attr_accessor :balance

  def initialize(id, balance=0.0)
    @id = id
    @balance = balance
  end
end

#require User start A
#require User dest B #require transaction money : user minus to represent A->B; use B->A then positve number
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
class SystemApp
  #hash1 user-> wallet
  #hash2 user-> transaction
  include Singleton

  @@userList = Hash.new
  @@userIdToUser = Hash.new
  @@usertoWallet = Hash.new
  @@usertoTransaction = Hash.new 

  attr_reader :userList, :usertoWallet
  attr_accessor :usertoTransaction

  def initialize(user, wallet)
    @user = user
    @wallet = wallet
  end

  def self.linkUserAndWallet(user, wallet)
    usertoWallet[:user] = wallet 
  end

  def self.getWalletByUser()
    wallet = @@usertoWallet[:user]
  end

  def self.recordTransaction()
  end

  # def self.getTopNRichestUser(n)
  # end

  # def self.getTotalIncomeForUserByDate(user, date)
  # end
end


def main()
  #1. Create Sysetm
  walletSystem = SystemApp.new(nil, nil) 

  #2. Create User
  alex = User.new(1231, "Alex", walletSystem)
  
  #3. Create Wallet
  alexswallet = Wallet.new(2222222, 0.0)

  #link user and wallet
  walletSystem.linkUserAndWallet(1231, AlexsWallet)
end

