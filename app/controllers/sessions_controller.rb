class SessionsController < ApplicationController

  skip_before_filter :check_invitation

  def new
    redirect_to root_url if current_user
  end

  def create
    user = User.where(email: params[:email].downcase.strip).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.update_attributes(sign_in_count: user.sign_in_count + 1, last_sign_in_at: Time.now)
      redirect_to root_url#, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
