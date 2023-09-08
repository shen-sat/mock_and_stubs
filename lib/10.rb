# different syntaxes:
# 1) "allow"
# 2) using class methods 
class Drawdown
	def self.call(id, amount)
		response = BankApi.call(id, amount)
		
		if response[:status_code] == 200
			Publisher.call(id, amount)
			return true
		end

		return false
	end
end


class BankApi
	def self.call(id, amount)
		puts "Calls Barclays and moves money"
		# BarclaysClient.make_drawdown(id, amount)
		# if successful, this would return a status code 200, else 4XX or 5XX
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
		allow(BankApi).to receive(:call).and_return({ status_code: 200 })
		# expectation on the class, not an instance
		expect(Publisher).to receive(:call).with(1111, 10_000)

		result = Drawdown.call(1111, 10_000)
		
		expect(result).to eq true
	end
end