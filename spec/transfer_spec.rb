require 'spec_helper'
require './lib/banking'



describe Banking::Transfer do

	before :all do
		@transfer = Banking::Transfer.new(1,2,100)
	end
	
	describe 'initialize' do 
		context 'Must create a new transfer' do
			
			it 'Transfer sourceAccount' do
				expect(@transfer.sourceAccount).to be 1
			end
			it 'Transfer destinyAccount' do
				expect(@transfer.destinyAccount).to be 2
			end
			it 'Transfer amount' do
				expect(@transfer.amount).to be 100
			end
		end
	end
	
end