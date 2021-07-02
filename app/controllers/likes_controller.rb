class LikesController < ApplicationController
  def create
    @user = User.find(session[:user_id])
    @secret = Secret.find(params[:secret])
    @like = Like.create(user: @user, secret: @secret)
    redirect_to "/secrets"
  end

  def destroy
    # unless params[:id].to_i == current_user.id
    #   redirect_to "/users/#{current_user.id}" 
    # else
      like = Like.where(secret_id: params[:id], user_id: current_user.id)
      like.destroy_all
      redirect_to "/secrets"
    # end
  end
end
