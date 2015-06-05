class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_invitation

private

  def current_user
    if params[:shh] && params[:shh] == ENV['shh'] && params[:uid]
      session[:user_id] = params[:uid].to_i
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    if current_user.nil?
      redirect_to login_url, alert: "Please sign in"
    elsif current_user.admin? or current_user.courses_taught.any? and current_user.invitation_code.blank?
      redirect_to office_root_url
    end
  end

  def check_invitation
    if current_user and current_user.invitation_code.present?
      redirect_to invite_url(invitation_code: current_user.invitation_code), notice: "Please check and update your details first"
    end
  end

end
