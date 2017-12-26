class AgenciesController < ApplicationController

	before_action :set_agency, only: [:show, :edit, :update, :destroy]

	def index
		@agencies = Agency.all
	end

	def new
		@agency = Agency.new
	end

	def show
	end

	def edit
	end

	def create
		@agency = Agency.new(agency_params)
		if @agency.save
			flash[:success] = "Agência cadastrada com sucesso!"
			redirect_to agencies_path
		else
			render 'new'
		end
	end

	def update 
		if @agency.update(agency_params)
			flash[:success] = "Agência atualizada com sucesso"
			redirect_to agencies_path
		else
			render 'edit'
		end
	end

	def destroy
		@agency.destroy
		flash[:danger] = "Agência e todas as contas relacionadas a ela foram apagadas."
		redirect_to agencies_path
	end
	
	private

	def agency_params
		params.require(:agency).permit(:number, :address)
	end

	def set_agency
		@agency = Agency.find(params[:id])
	end

end