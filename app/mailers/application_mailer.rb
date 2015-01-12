class ApplicationMailer < ActionMailer::Base
  default from: "IAAC MGMT <notifications@mgmt.iaac.net>"
  include Roadie::Rails::Automatic
end
