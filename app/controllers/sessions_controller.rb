class SessionsController < ApplicationController
  layout "application"
  before_action :require_login, except: [:new, :create] 
  def new
  end
  
  def create
    @user =User.find_by_email(session_params[:email]).try(:authenticate, session_params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
      else
        flash[:errors] = ["Invalid Combination"]
        redirect_to '/sessions/new'
      end
  end
  
  def destroy
    unless params[:id].to_i == current_user.id
      redirect_to "/users/#{current_user.id}" 
    else
      reset_session
      redirect_to '/sessions/new'
    end
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
