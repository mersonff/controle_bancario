class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
		@user = User.new
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Bem vindo #{@user.email} ao Simulador de Sistema Bancário"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			session[:user_id] = @user.id
			flash[:success] = "Sua conta foi atualizada com sucesso."
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		flash[:danger] = "Sua conta foi apagada com sucesso."
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:danger] = "Você só pode editar ou deletar sua própria conta"
			redirect_to users_path
		end
	end


end