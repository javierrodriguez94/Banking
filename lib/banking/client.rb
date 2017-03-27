

module Banking

	class Client

		attr_reader :name, :accounts

		def initialize name
			@name = name
			#Client can have many accounts
			@accounts = [] 
		end

		def addAccount account
			@accounts << account
		end

	end

end