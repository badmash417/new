class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: 'saginalajani@gmail.com', subject: "new user named #{@user.first_name}")
  end
end
