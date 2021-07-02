class SecretsController < ApplicationController
  layout "application" 
  def index
    @secrets = Secret.all
  end
  
  def create
    @user = User.find(session[:user_id])
    @secret = Secret.create(content: params[:content], user: @user)
    if @secret.valid?
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @secret.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    user = User.find(session[:user_id])
    secret = Secret.find(params[:id])
    secret.destroy 
    redirect_to  "/users/#{user.id}"
  end
end
