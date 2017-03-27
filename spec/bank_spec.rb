require 'spec_helper'
require './lib/banking'



describe Banking::Bank do

	before :each do
		@bank = Banking::Bank.new( "Test_Bank" )
		@other_bank = Banking::Bank.new( "Other_Bank" )
		@client1 = Banking::Client.new("Test_client")
		@client2 = Banking::Client.new("Test_client")
		@client3 = Banking::Client.new("Test_client")
		@account1 = @bank.createAccount(@client1)
		@account2 = @bank.createAccount(@client2)
		@account3 = @other_bank.createAccount(@client3)
	end

	describe 'initialize' do 
		context 'Must create an empty bank' do
			it 'Create a bank' do
				expect(@bank).not_to be_nil
			end

		end
	end

	describe 'createAccount' do 
		context 'Create a account successfully' do
			it 'Creates an account on client' do
				expect(@client1.accounts).not_to be_empty
			end			

		end
	end

	describe 'internalTransfer' do 
		context 'Issue a transfer between internal accounts' do
			it 'Fails with not enought founds' do
				expect{@bank.internalTransfer @account1, @account2, 100}.to raise_error(RuntimeError)
			end
			it 'Success with internal accounts' do
				@account1.addFounds(100)
				expect(@bank.internalTransfer @account1, @account2, 100).to be true
				expect(@account1.balance).to be 0
				expect(@account2.balance).to be 100
			end
			it 'Fails with external accounts' do
				expect{@bank.internalTransfer @account1, @account3, 100}.to raise_error(RuntimeError)
			end
		end
	end

	describe 'sendTransfer' do 
		context 'SendTransfer' do
			it 'Fails without found' do
				expect{sendTransfer @account1, @account3, 100}.to raise_error
			end
			it 'Success with founds' do
				@account1.addFounds 105
				begin
					@bank.sendTransfer @account1, @account3, 100
					expect(@account1.balance).to be(0)
					expect(@account3.balance).to be(100)
				rescue 
					#Transfer will fail with a 0.3 probability
					expect(@account1.balance).to be(105)
					expect(@account3.balance).to be(0)
				end
			end
			
		end
	end

	describe 'receiveTransfer' do 
		context 'Must create an empty bank' do
			it 'receives money sucessfully' do
			
				@account1.addFounds 205
				begin
					@other_bank.receiveTransfer @account1, @account3, 200
					expect(@account3.balance).to be 200
				rescue
					expect(@account3.balance).to be 0
				end
			end

			it 'receives money sucessfully' do

				@account1.addFounds 205
				begin
					@other_bank.receiveTransfer @account1, @account3, 200
					expect(@account3.balance).to be(200)
				rescue
					#Transfer will fail with a 0.3 probability
					expect(@account3.balance).to be(0)
				end
			end

		end
	end
end
