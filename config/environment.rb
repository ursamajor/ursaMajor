# Load the Rails application.
require File.expand_path('../application', __FILE__)

environment_variables = File.join(Rails.root, 'config', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables)

require "#{Rails.root}/lib/api.rb"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}