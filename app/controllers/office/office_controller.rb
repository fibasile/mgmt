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
      unless current_user.admin? and current_user.courses_taught.any?
        redirect_to root_url
      end
    else
      redirect_to login_url, alert: "Please sign in"
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to do this."
    redirect_to(request.referrer || office_root_path)
  end

end
