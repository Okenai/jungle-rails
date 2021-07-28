class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"
  
  def confirmation_email(order)
    @order = order
    mail(to: @order.email, subject: 'Welcome to My Awesome Site')
  end
end
