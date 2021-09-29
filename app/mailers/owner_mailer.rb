class OwnerMailer < ApplicationMailer
    def mail_new_owner(mail)
        mail to: "hi@amorekazonsou.com", subject: "Inquiry confirmation email"
    end
end
