class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			cookies.signed[:user_id] = user.id
			flash[:success] = "Você fez login com sucesso."
			redirect_to user
		else
			flash.now[:danger] = "Há algo errado com suas informação de login."
			render 'new'
		end
	end
end