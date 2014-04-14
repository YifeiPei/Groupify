class ContactMailer < ActionMailer::Base
  default from: "noreply@groupify.com.au"
   
    def contact(from, to, subject, msg)
    mail(:to =>  to, :subject => subject, :body => msg)
  end
end
