# Preview all emails at http://localhost:3000/rails/mailers/relay_mailer
class RelayMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/relay_mailer/relay_mail
  def relay_mail
    args = {
      email: 'me@example.com',
      name: 'Testy McGee',
      fromEmail: 'you@example.com',
      message: 'Hello, this is a message!'
    }
    RelayMailer.relay_mail(args, 'example.com')
  end

end
