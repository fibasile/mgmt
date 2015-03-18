class ApplicationMailer < ActionMailer::Base
  default from: "IAAC MGMT <notifications@mgmt.iaac.net>", cc: "john@bitsushi.com"
  include Roadie::Rails::Automatic
end
