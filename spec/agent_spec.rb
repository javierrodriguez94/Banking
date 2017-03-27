require 'spec_helper'
require './lib/banking'



describe Banking::Agent do

	before :each do
		@bank = Banking::Bank.new( "Test_Bank" )
		@other_bank = Banking::Bank.new( "Other_Bank" )
		@client1 = Banking::Client.new("Test_client1")
		@client2 = Banking::Client.new("Test_client2")
		@account1 = @bank.createAccount(@client1)
		@account2 = @other_bank.createAccount(@client2)
		@account3 = @bank.createAccount(@client2)
	end
	describe 'transfer' do 
		context 'Issue transfer between two accounts, different banks' do
			it 'Sucessfull transfer' do
				@account1.addFounds 50000
				Banking::Agent.new().transfer @account1, @account2, 20000
				expect(@account1.balance).to be (50000 - ( 20000 + (20000/1000.to_f).ceil*5 ) )
				expect(@account2.balance).to be 20000
			end
			it 'Fails with not enought founds' do
				@account1.addFounds 50000
				expect{Banking::Agent.new().transfer @account1, @account2, 200000}.to raise_error
			end

		end

		context 'Issue transfer between two accounts, same banks' do
			it 'Sucessfull transfer' do
				@account1.addFounds 50000
				Banking::Agent.new().transfer @account1, @account3, 20000
				expect(@account1.balance).to be (50000 - 20000 )
				expect(@account3.balance).to be 20000
			end
			it 'Fails with not enought founds' do
				@account1.addFounds 50000
				expect{Banking::Agent.new().transfer @account1, @account3, 200000}.to raise_error
			end

		end
	end
end
