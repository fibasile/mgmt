class Office::OfficeController < ApplicationController
  include Pundit

  layout 'office'
  respond_to :html
  before_filter :authenticate_admin!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, :only => :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def authenticate_admin!
    if current_user
      unless current_user.admin? or current_user.courses_taught.any?
        Keen.publish("failed_admin_attempt", { :email => current_user.email }) if Rails.env.production?
        redirect_to root_url
      end
    else
      redirect_to login_url, alert: "Please sign in"
    end
  end

  def user_not_authorized
    if current_user and Rails.env.production?
      Keen.publish("pundit_unauthorized", { :email => current_user.email })
    end
    flash[:alert] = "You are not authorized to do this."
    redirect_to(request.referrer || office_root_path)
  end

end
