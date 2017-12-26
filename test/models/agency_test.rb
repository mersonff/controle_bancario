require 'test_helper'

class AgencyTest < ActiveSupport::TestCase

	def setup
		@agency = Agency.new(number: 001, address: "Rua JK 151, Centro")
	end

	test "agency should be valid" do
		assert @agency.valid?
	end

	test "agency should have a number" do
		@agency.number = nil
		assert_not @agency.valid?
	end

	test "agency should have a address" do
		@agency.address = " "
		assert_not @agency.valid?
	end

	test "number should be unique" do
		duplicated_agency = @agency.dup
		@agency.save
		assert_not duplicated_agency.valid?
	end
end