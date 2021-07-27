require 'date'
require 'singleton'

class User
  attr_reader :userid, :wallet, :system
  attr_accessor :userName

  def initialize(userid, userName, wallet, system) 
    @userid = userid
    @userName = userName
    @wallet = wallet
    @system = system
  end

  # User can deposit money into her wallet
  def deposit(money)
    @wallet.balance += money
    depositTransaction = Transaction.new(@userName, @userName, money, DateTime.now)
    @system.recordTransaction(self, depositTransaction)
    puts "#{@userName} deposit #{money} to wallet, current balance is #{wallet.balance}"
  end

  # User can withdraw money from her wallet def withdraw(money)
  def withdraw(money)
    unless wallet.balance >= money then
      @wallet.balance -= money 
      depositTransaction = Transaction.new(@userName, @userName, -money, DateTime.now)
      @system.recordTransaction(self, depositTransaction)
      puts "#{@userName} withdraw sucessed!, current balance is #{wallet.balance}"
    else
      puts "#{@userName} do not have enough money for withdraw #{money}, current balance is #{wallet.balance}"
    end
  end

  # User can send money to another user
  def transfer(money, destUser)
    unless wallet.balance >= money then
      @wallet.balance -= money
      destUser.wallet.balance += money
      depositTransaction = Transaction.new(@userName, destUesr.userName, -money, DateTime.now)
      @system.recordTransaction(self, depositTransaction)
      puts "#{@userName} transfer #{money} to #{destUser.userName}, current balance for #{@userName} is #{wallet.balance}"
    else 
      puts "#{@userName} do not have enough money to transfer #{money}, current balance is #{wallet.balance}"
    end
  end
end


#Get the top N richest user
#Get total income and outcome of a special day
#User can see her wallet transactino history
class Wallet
  attr_reader :id, :system
  attr_accessor :balance

  def initialize(id, balance=0.0, system)
    @id = id
    @balance = balance
    @system = system
  end
end

#require User start A
#require User dest B #require transaction money : user minus to represent A->B; use B->A then positve number
#require date
class Transaction

  attr_reader :start, :dest, :money, :date

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

  @@userIdToUser = Hash.new
  @@usertoWallet = Hash.new
  @@usertoTransaction = Hash.new 

  @@transactionArray = Array.new

  attr_reader :usertoWallet
  attr_accessor :usertoTransaction

  def initialize(createdate, user, wallet, transactionArray, transaction)
    @createdate = createdate
    @user = user
    @wallet = wallet
    @transactionArray = transactionArray
    @transaction = transaction
  end

  def linkUserAndWallet(user, wallet)
    # usertoWallet = Hash[:user => wallet]
    # usertoWallet.store(:user => wallet)
    @@usertoWallet[:user] = wallet
  end

  def linkUserAndTransactionHistory(user, transactionArray)
    @@usertoTransaction[:user] = transactionArray
  end

  def getWalletByUser(user)
    wallet = @@usertoWallet[:user]
  end

  def recordTransaction(user, transaction)
    @@transactionArray = @@usertoTransaction[:user]
    @@transactionArray << transaction
    @@usertoTransaction[:user] = transactionArray
    puts "Transaction recorded successed, #{transaction.start} to #{transaction.dest} for #{transaction.money} #{transaction.date} "
  end

  def getTransaction(user)
    transactionArray = usertoTransaction[:user]
    puts "#{user.userName} has #{transactionArray.length()} transactions"
  end

  # def getTopNRichestUser(n)
  #   assertArray = Array.new
    
  #   usertoWallet.each do |key, value|
  #     usersBalance = value.balance
  #     usersName = key.userName
  #     userAndAssert = Tuple.new(userName, usersBalance)
  #     assertArray << userAndAssert
  #   end
  # end

  def getTotalIncomeForUserByDate(user, date)
    transactionArray = usertoTransaction[:user]

    income = 0.0
    outcome = 0.0

    for transaction in transactionArray
      transactionDate = transaction.date.strftime("%m/%d/%Y")
      unless date == transactionDate then
        money = transaction.money
        if money > 0
          income += money
        else
          outcome -= money
        end
      end
    end
    puts "#{user.userName} income for #{date} is #{income}, outcome is #{outcome} "
  end
end


def main()
  #1. Create Sysetm
  walletSystem = SystemApp.new(DateTime.now, nil, nil, nil, nil) 

  #2. Create Wallet
  alexwallet = Wallet.new(2222222, 0.0, walletSystem)

  #3. Create User
  alex = User.new(1231, "Alex", alexwallet, walletSystem)

  #link user and wallet
  walletSystem.linkUserAndWallet(alex, alexwallet)

  #First user deposit money
  alex.deposit(2.2)

  #First user withdraw money
  #2. Create second user

  #3. Create second users wallet
end

main()

