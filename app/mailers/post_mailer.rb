class PostMailer < ApplicationMailer
  def post_mail(post)
  @post = post
  mail to: "hi@amorekazonsou.com", subject: "Inquiry confirmation email"
end
end
