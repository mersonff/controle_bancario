class AccountsController < ApplicationController

	before_action :set_account, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:index, :show]

	def index
		@accounts = Account.paginate(page: params[:page], per_page: 5)
	end

	def new
		@account = Account.new
	end

	def show
	end

	def edit
	end

	def create
		@account = Account.new(account_params)
		if @account.save
			flash[:success] = "Conta cadastrada com sucesso!"
			redirect_to accounts_path
		else
			render 'new'
		end
	end

	def update 
		if @account.update(account_params)
			flash[:success] = "Conta atualizada com sucesso"
			redirect_to accounts_path
		else
			render 'edit'
		end
	end

	def destroy
		flash[:danger] = "Contas não podem ser apagadas."
		redirect_to accounts_path
	end
	
	private

	def account_params
		params.require(:account).permit(:account_number, :limit, :balance, :agency_id )
	end

	def set_account
		@account = Account.find(params[:id])
	end

end