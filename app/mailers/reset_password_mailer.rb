class ResetPasswordMailer < ActionMailer::Base
  default :from => "cutehailin@163.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reset_password_mailer.confirm.subject
  #
  def confirm
    @greeting = "Hi"

    mail :to => "cutehailin@163.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reset_password_mailer.sent.subject
  #
  def sent
    @greeting = "Hi"

    mail :to => "cutehailin@163.com"
  end
end
