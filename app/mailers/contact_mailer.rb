class ContactMailer < ActionMailer::Base
  default from: "admin@groupify.com.au"
   
    def contact(student)
    @student = student
    mail(:to => "#{student.first_name} <#{student.email}>", :subject => "hello")
  end
end
