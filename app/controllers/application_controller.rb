class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_invitation

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to login_url, alert: "Please sign in" if current_user.nil?
  end

  def check_invitation
    if current_user and current_user.invitation_code.present?
      redirect_to invite_url(invitation_code: current_user.invitation_code), notice: "Please check and update your details first"
    end
  end

end
