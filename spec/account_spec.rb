require 'spec_helper'
require './lib/banking'


describe Banking::Account do

	before :each do
		@account = Banking::Account.new(Banking::Client.new("Test_client"), "Bank")
	end

	describe 'initialize' do 
		context 'Must create accounts with different numbers' do
			it 'Check that accounts created consecutively has different numbers' do
				expect(@account.number).to be Banking::Account.new(Banking::Client.new("Test_client2"), "Bank").number - 1
			end
		end
	end

	describe '.balance' do

		context 'Must return the balance of the account' do
	  		it 'Returns balance of a new account, 0' do
	    		expect(@account.balance).to be 0
	  		end
		
	  		it 'Return the balance of account before add 100' do
	    		@account.addFounds(100)
	    		expect(@account.balance).to be 100
	  		end
		
	  		it 'Return the balance of account before add 100 and remove 50' do
	    		@account.addFounds(100)
	    		@account.removeFounds(50)
	    		expect(@account.balance).to be 50
	  		end
		end

	end

	describe '.addFounds' do

		context 'Must add founds to balance of the account' do
	  		it 'Add 0' do
	  			@account.addFounds(0)
	    		expect(@account.balance).to be 0
	  		end

	  		it 'Add 100' do
	    		@account.addFounds(100)
	    		expect(@account.balance).to be 100
	  		end
		end
	end

end