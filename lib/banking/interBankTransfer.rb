require './lib/banking/transfer'

module Banking

	class InterBankTransfer < Transfer
		#We can easily change this values without editing code
		@@maxLimit = 1000
		@@commission = 5

		def self.commission
			@@commission
		end

		def self.maxLimit
			@@maxLimit
		end
		
		def initialize from, to, amount, bank, type
			raise "Inter-BankTransferError - This transfers have a limit of 1000" if amount > @@maxLimit
			super from, to, amount
			@bank = bank
			@type = type
			@commission = @@commission
		end

	end

end