# different syntaxes:
# 1) "allow"
# 2) using class methods 
class Drawdown
	def self.call(id, amount, bank_api)
		response = bank_api.call(id, amount)
		
		if response[:status_code] == 200
			Publisher.call(id, amount)
			return true
		end

		return false
	end
end


class BankApi
	def call(id, amount)
		puts "Makes a call to Barclays to move money"
		# BarclaysClient.make_drawdown(id, amount)
		# is successful, this word return a ststus code 200, else 4XX or 5XX
	end
end

class Publisher
	def self.call(id, amount)
		puts "Publishes message to kafka"
	end
end

RSpec.describe Drawdown do
	it 'happy path' do
		# different syntax for stubs:
		bank_api = instance_double(BankApi)
		allow(bank_api).to receive(:call).and_return({ status_code: 200 })
		# expectation on the class, not an instance
		expect(Publisher).to receive(:call).with(1111, 10_000)

		result = Drawdown.call(1111, 10_000, bank_api)
		
		expect(result).to eq true
	end
end