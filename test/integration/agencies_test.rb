require 'test_helper'

class AgenciesTest < ActionDispatch::IntegrationTest

	def setup
		@agency = Agency.create!(number: 1, address: "Rua JK, 151, Centro")
		@agency2 = Agency.create!(number: 2, address: "Rua Valdir Leopercio, 574, Centro")
	end
  
  test "should get agencies index" do
  	get agencies_path
  	assert_response :success
  end

  test "should get agencies listing" do
  	get agencies_path
  	assert_template 'agencies/index'
  	assert_select 'a[href=?]', edit_agency_path(@agency), text: "Editar"
  	assert_select 'a[href=?]', agency_path(@agency), text: "Deletar"
  end

  test "should create a new valid agency" do
  	get new_agency_path
  	assert_template 'agencies/new'
  	number_of_agency = 3
  	address_of_agency = "Endereço qualquer"
  	assert_difference 'Agency.count', 1 do
  		post agencies_path, params: { agency: { number: number_of_agency, address: address_of_agency } }
  	end
  	follow_redirect!
  	assert_match address_of_agency, response.body
  end

  test "should reject a invalid agency" do
  	get new_agency_path
  	assert_template 'agencies/new'
  	assert_no_difference 'Agency.count' do
  		post agencies_path, params: { agency: { number: nil, address: " " } }
  	end
  	assert_template 'agencies/new'
  	assert_select 'h2.error-title'
  	assert_select 'div.error-body'
  end

  test "successfully agency update" do
  	get edit_agency_path(@agency)
  	assert_template 'agencies/edit'
  	updated_number = 3
  	updated_address = "Endereço qualquer"
  	patch agency_path(@agency), params: { agency: { number: updated_number, address: updated_address } }
  	assert_redirected_to agencies_path
  	assert_not flash.empty?
  	@agency.reload
  	assert_match updated_address, @agency.address
  end

  test "reject a invalid agency update" do
  	get edit_agency_path(@agency)
  	assert_template 'agencies/edit'
  	patch agency_path(@agency), params: { agency: { number: nil, address: "" } }
  	assert_template 'agencies/edit'
  	assert_select 'h2.error-title'
  	assert_select 'div.error-body'
  end

   test "successfully agency delete" do
  	get agencies_path
  	assert_template 'agencies/index'
  	assert_select 'a[href=?]', agency_path(@agency), text: "Deletar"
  	assert_difference 'Agency.count', -1 do
  		delete agency_path(@agency)
  	end
  	assert_redirected_to agencies_path
  	assert_not flash.empty?
  end

end
