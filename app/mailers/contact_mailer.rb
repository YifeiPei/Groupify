class ContactMailer < ActionMailer::Base
  default from: "admin@groupify.com.au"
   
    def contact(student_emails)
    mail(:to =>  student_emails, :subject => "hello")
  end
end
