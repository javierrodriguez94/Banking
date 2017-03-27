require 'spec_helper'
require './lib/banking'



describe Banking::Client do

	before :each do
		@client = Banking::Client.new("Test_client")
	end

	describe 'initialize' do 
		context 'Must create a new client' do
			it 'Client with Test_client name' do
				expect(@client.name).to eq "Test_client"
			end
			it 'Client without accounts' do
				expect(@client.accounts).to be_empty
			end
		end
	end

	describe '.addAccount' do 
		context 'Must add a account to a client' do
			it 'Add only one account to a client' do
				bank = Banking::Bank.new("Test_bank")
				account = bank.createAccount(@client)
				expect(@client.accounts).to include(account)
			end
		end
	end
	
end