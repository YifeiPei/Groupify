require 'development_mail_interceptor'
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.live.com",
  :port                 => "587",
  :domain               => "groupify.com.au",
  :user_name            => "noreply@groupify.com.au",
  :password             => "leap4joy",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?