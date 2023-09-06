class Drawdown
	def self.call(id, amount, bank_api)
		response = bank_api.call(id, amount)
		
		response[:status_code] == 200
	end
end


class BankApi
	def call(id, amount)
		puts "Makes a call to Barclays to move money"
		# BarclaysClient.make_drawdown(id, amount)
		# is successful, this word return a ststus code 200, else 4XX or 5XX
	end
end

RSpec.describe Drawdown do
	it 'happy path' do
		bank_api = BankApi.new

		result = Drawdown.call(1111, 10_000, bank_api)
		
		expect(result).to eq true
		# is there a risk with this test?
	end
end