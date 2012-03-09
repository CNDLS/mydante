class Notifier < ActionMailer::Base
  default from: "cndls_developers@georgetown.edu"
  
  def greet(user)
    # send user an email, just to show that it works.
    @user = user
    attachments["cndls_logo.gif"] = File.read(Rails.root.join('app/assets/images/cndls_logo.gif'))  
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Howdy")
  end
end
