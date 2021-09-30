class PostMailer < ApplicationMailer
  def post_mail(post)
  @post = post
  mail to: "anselmehado85@yahoo.com", subject: "Inquiry confirmation email"
end
end
