

module Banking

	class Transfer
		
		attr_reader :sourceAccount, :destinyAccount, :amount

		def initialize sourceAccount, destinyAccount, amount 
			@sourceAccount = sourceAccount
			@destinyAccount = destinyAccount
			@amount = amount
		end

	end

end