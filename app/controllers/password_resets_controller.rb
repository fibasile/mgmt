class PasswordResetsController < ApplicationController

  skip_before_filter :check_invitation
  layout 'sessions'

  def create
    Keen.publish("password_reset_request", { :email => params[:email] }) if Rails.env.production?
    if user = User.find_by(email: params[:email])
      user.send_password_reset
      redirect_to login_url, notice: "Email sent with password reset instructions."
    else
      flash.now[:notice] = "User not found"
      render :new
    end

  end

  def edit
    begin
      @user = User.find_by!(password_reset_token: params[:id])
    rescue
      session[:user_id] = nil
      redirect_to login_url, notice: "User not found. Try resetting your password again?"
    end
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(password_reset_params)
      @user.update_attributes(password_reset_token: nil, password_reset_sent_at: nil)
      redirect_to login_url, notice: "Password has been reset!"
    else
      render :edit
    end
  end

private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
