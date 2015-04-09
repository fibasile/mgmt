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
      if user.courses_taught.any? or user.admin?
        Keen.publish("admin_login", { :email => params[:email].downcase.strip }) if Rails.env.production?
        redirect_to office_root_url
      else
        Keen.publish("student_login", { :email => params[:email].downcase.strip }) if Rails.env.production?
        redirect_to root_url
      end
    else
      Keen.publish("failed_login", { :email => params[:email].downcase.strip }) if Rails.env.production?
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    Keen.publish("logout", { :email => current_user.email }) if Rails.env.production?
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
