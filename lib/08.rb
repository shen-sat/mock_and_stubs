class Drawdown
	def self.call(id, amount, bank_api, publisher)
		response = bank_api.call(id, amount)
		
		if response[:status_code] == 200
			publisher.call(id, amount)
			return true
		end

		return false
	end
end


class BankApi
	def call(id, amount)
		puts "Calls Barclays and moves money"
		# BarclaysClient.make_drawdown(id, amount)
		# if successful, this would return a status code 200, else 4XX or 5XX
	end
end

class Publisher
	def call(id, amount)
		puts "Publishes message to kafka"
	end
end

RSpec.describe Drawdown do
	it 'happy path' do
		bank_api = instance_double(BankApi, call: { status_code: 200 })
		# let's mock!
		publisher = instance_double(Publisher)
		# note: we are not telling the double what to do; we are VERIFYING what it does
		expect(publisher).to receive(:call).with(1111, 10_000)

		result = Drawdown.call(1111, 10_000, bank_api, publisher)
		
		expect(result).to eq true
	end
end