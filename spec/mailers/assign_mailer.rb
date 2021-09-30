class AssignMailer < ApplicationMailer
  default from: 'from@example.com'

  def assign_mail(mail)
      mail to: "anselmehado85@yahoo.com", subject: "agenda has been deleted"
  end
end
