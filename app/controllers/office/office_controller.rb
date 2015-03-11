class Office::OfficeController < ApplicationController
  include Pundit

  layout 'office'
  respond_to :html
  before_filter :authenticate_admin!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, :only => :index

private

  def authenticate_admin!
    redirect_to login_url, alert: "Please sign in" if current_user.nil? or !current_user.admin?
  end

end
