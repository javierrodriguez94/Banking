

module Banking

	class Bank
		@@overdrawn = false

		attr_reader :name
		
		def initialize name
			@name = name
			@accounts = {}
			@clients = []
			@transfers = []
		end


		def createAccount client
			account = Account.new(client, self)
			raise "Duplicate account number" unless @accounts[account.number] == nil
			@accounts[account.number] = account
			client.addAccount(account)
			account
		end


		def internalTransfer sourceAccount, destinyAccount, amount

			raise "TransferError - Invalid source account " if @accounts[sourceAccount.number].nil?
			raise "TransferError - Invalid destiny account " if @accounts[destinyAccount.number].nil?

			unless @@overdrawn
				#The bank may permit overdrawn on transfers
				raise "TransferError - Not enought money" if @accounts[sourceAccount.number].balance < amount
			end

			@accounts[sourceAccount.number].removeFounds amount
			@accounts[destinyAccount.number].addFounds amount


			@transfers << Banking::IntraBankTransfer.new(sourceAccount, destinyAccount, amount)

			true
		end


		def sendTransfer sourceAccount, destinyAccount, amount
			
			return false if @accounts[sourceAccount.number].nil?

			transfer = Banking::InterBankTransfer.new(sourceAccount, destinyAccount, amount, sourceAccount.bank, "send")

			unless @@overdrawn
				#The bank may permit overdrawn on transfers
				raise "TransferError - Not enought money" if @accounts[sourceAccount.number].balance < amount
			end

			@accounts[sourceAccount.number].removeFounds (amount + Banking::InterBankTransfer.commission)

			begin
				destinyAccount.bank.receiveTransfer sourceAccount, destinyAccount, amount
			rescue
				@accounts[sourceAccount.number].addFounds (amount + Banking::InterBankTransfer.commission)
				raise "TransferError - Receiver Bank Error"
			end

			@transfers << transfer

		end


		def receiveTransfer sourceAccount, destinyAccount, amount

			raise "Transfer Error" if Random.rand <= 0.3  #Simulate 30% error
			
			@accounts[destinyAccount.number].addFounds amount
					
			@transfers << Banking::InterBankTransfer.new(sourceAccount, destinyAccount, amount, destinyAccount.bank, "received")
			
			return true
		
		end

		def transfers_history
			@transfers
		end

	end

end