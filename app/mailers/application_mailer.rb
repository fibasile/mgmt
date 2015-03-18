class ApplicationMailer < ActionMailer::Base
  default from: "IAAC MGMT <notifications@mgmt.iaac.net>", cc: "maria.kuptsova@iaac.net"
  include Roadie::Rails::Automatic
end
