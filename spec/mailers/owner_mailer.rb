class OwnerMailer < ApplicationMailer
    def mail_new_owner(mail)
        mail to: "anselmehado85@yahoo.com", subject: "Inquiry confirmation email"
    end
end
