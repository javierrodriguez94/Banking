require './lib/banking/transfer'

module Banking

	class IntraBankTransfer < Transfer

		def initialize from, to, amount 
			@from = from
			@to = to
			@amount = amount
		end

	end

end