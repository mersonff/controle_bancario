class TransactionsController < ApplicationController

	before_action :set_transaction, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@transactions = Transaction.paginate(page: params[:page], per_page: 5)
	end

	def new
		@transaction = Transaction.new
	end

	def create
		@transaction = Transaction.new(transaction_params)
		@transaction.user = current_user
		@transaction.date = Time.now
		@account = @transaction.account
		types_of_transactions = ["Depósito", "Estorno" , "Transferência"]
		if @transaction.value > @transaction.account.limit
			flash.now[:danger] = "Transação não realizada, valor maior que o limite da conta."
			render 'new'
		elsif types_of_transactions.include? @transaction.type_of_transaction
			@account.balance += @transaction.value
			@transaction.save
			@account.save
			flash[:success] = "Transação salva com sucesso."
			redirect_to transactions_path
		elsif @transaction.type_of_transaction = "Saque"
			@account.balance -= @transaction.value
			@transaction.save
			@account.save
			flash[:success] = "Transação salva com sucesso."
			redirect_to transactions_path
		else
			render 'new'
		end
	end

	private 

	def set_transaction
		@transaction = Transaction.find(params[:id])
	end

	def transaction_params
		params.require(:transaction).permit(:value, :type_of_transaction, :account_id)
	end

	def require_same_user
		if current_user != @transaction.user
			flash[:danger] = "Você só pode editar ou deletar suas transações"
			redirect_to users_path
		end
	end

end