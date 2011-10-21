#encoding: UTF-8

class ResetPasswordMailer < ActionMailer::Base
  default :from => "adamstudio.cn@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reset_password_mailer.confirm.subject
  #
  def confirm(to_email, reset_password_url)
    @reset_password_url = reset_password_url
    mail :to => to_email
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
