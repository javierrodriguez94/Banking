

module Banking

	class Agent

		
		def transfer from, to, amount
		
			raise "Transfer Agent Error - incorrect accounts " if from.bank.nil? || to.bank.nil?

			if from.bank == to.bank
				#IntraBank
				#No commissions
				#No limit
				#No errors
				raise "Transfer Agent Error - source account doesn't have enought money" if from.balance < amount
				from.bank.internalTransfer from, to, amount

			else
				#InterBank
				#Commissions
				#Limit
				#Errors
				limit = Banking::InterBankTransfer.class_variable_get(:@@maxLimit)
				commission = Banking::InterBankTransfer.class_variable_get(:@@commission)
				transfers_needed = (amount/limit.to_f).ceil
				total_comission = commission * transfers_needed
				total_amount = amount + total_comission

				raise "Transfer Agent Error - source account doesn't have enought money" if from.balance < total_amount

				while amount != 0

					amount_to_transfer = (amount > limit ? limit : amount)
					
					begin
						next if from.bank.sendTransfer(from, to, amount_to_transfer)  == false
					rescue
						next
					end
					amount -= amount_to_transfer
				end				 

			end

		end
		
	end

end