class Office::OfficeController < ApplicationController
  layout 'office'
  respond_to :html
  before_filter :authenticate_admin!

private

  def authenticate_admin!
    redirect_to login_url, alert: "Please sign in" if current_user.nil? or current_user.email != 'john@iaac.net'
  end

end
