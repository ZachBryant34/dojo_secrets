class UsersController < ApplicationController
  layout "application"
  before_action :require_login, except: [:new, :create] 
  before_action :match_id, except: [:new, :create]
  def new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
        session[:user] = @user.id
        redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end



  def show
    @user = User.find(params[:id])
    @secrets = Secret.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.email = params[:email] 
    @user.name = params[:name]
    if @user.valid?
        @user.save
        redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy 
    reset_session
    redirect_to '/users/new'
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation )
  end

  def match_id
    unless params[:id].to_i == current_user.id
      redirect_to "/users/#{current_user.id}" 
    end
  end
end
