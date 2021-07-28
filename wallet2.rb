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
    unless wallet.balance < money then
      @wallet.balance -= money 
      depositTransaction = Transaction.new(@userName, @userName, -money, DateTime.now)
      @system.recordTransaction(self, depositTransaction)
      puts "#{@userName} withdraw #{money} sucessed!, current balance is #{wallet.balance}"
    else
      puts "#{@userName} do not have enough money for withdraw #{money}, current balance is #{wallet.balance}"
    end
  end

  # User can send money to another user
  def transfer(money, destUser)
    unless wallet.balance < money then
      @wallet.balance -= money
      destUser.wallet.balance += money
      depositTransaction = Transaction.new(@userName, destUser.userName, -money, DateTime.now)
      @system.recordTransaction(self, depositTransaction)
      puts "#{@userName} transfer #{money} to #{destUser.userName}, current balance for #{@userName} is #{wallet.balance}"
    else 
      puts "#{@userName} do not have enough money to transfer #{money}, current balance is #{wallet.balance}"
    end
  end

  #show users balance
  def showbalance
    puts "#{@userName} has #{self.wallet.balance}"
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
  include Singleton

  @@usertoWallet = Hash.new 
  @@usertoTransaction = Hash.new 

  attr_reader :usertoWallet
  attr_accessor :usertoTransaction

  def initialize(createdate=DateTime.now, user=nil, wallet=nil, transactionArray=nil, transaction=nil)
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

  def linkUserAndTransactionHistory(user)
    transactionArray = Array.new
    @@usertoTransaction[:user] = transactionArray
  end

  def getWalletByUser(user)
    wallet = @@usertoWallet[:user]
  end

  def recordTransaction(user, transaction)
    transactionArray = @@usertoTransaction[:user]
    transactionArray << transaction
    @@usertoTransaction[:user] = transactionArray
    puts "Transaction recorded successed, #{transaction.start} to #{transaction.dest} for #{transaction.money} on #{transaction.date} "
  end

  def getTransaction(user)
    transactionArray = @@usertoTransaction[:user]
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
    transactionArray = @@usertoTransaction[:user]

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
    puts "#{user.userName} total income for #{transactionDate} is #{income}, total outcome is #{outcome} "
  end
end


def main()
  #1. Create Sysetm
  # walletSystem = SystemApp.new(DateTime.now, nil, nil, nil, nil) 
  walletSystem = SystemApp.instance

  #2. Create Wallet
  alexwallet = Wallet.new(2222222, 0.0, walletSystem)

  #3. Create User
  alex = User.new(1231, "Alex", alexwallet, walletSystem)

  #link user and wallet
  walletSystem.linkUserAndWallet(alex, alexwallet)

  #link user to transactionArray
  walletSystem.linkUserAndTransactionHistory(alex)

  #First user deposit money
  alex.deposit(2.2)

  #first user try to withdraw money
  alex.withdraw(1.1)

  #now alex has 1.1 in his wallet
  alex.withdraw(1.2) #This will print refused message

  #Create the second User wallet first
  evanwallet = Wallet.new(123123, 0.0, walletSystem)

  #create user evan
  evan = User.new(1231, "Evan", evanwallet, walletSystem)

  #link user and wallet
  walletSystem.linkUserAndWallet(evan, evanwallet)

  #link user to transactionArray
  walletSystem.linkUserAndTransactionHistory(evan)
  
  #Second user deposit money
  evan.deposit(3.2)

  #second user withdraw money
  evan.withdraw(1.0) 

  #seond user transfer money to first user
  evan.transfer(1.1, alex)

  #show evans balance
  evan.showbalance

  #get totalincome and outcome for special day
  walletSystem.getTotalIncomeForUserByDate(evan, 07/28/2021)

  #get evan's transaction history, return an array of transaction
  walletSystem.getTransaction(evan)

end

main()

