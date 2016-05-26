class RelayMailer < ApplicationMailer

  def relay_mail(params, site)
    @site = site
    @name = params[:name]
    @message = params[:message]
    @id = params[:phone] ? "#{@name} (phone: #{params[:phone]})" : @name
    mail(to: params[:email],
         reply_to: "\"#{@name}\"<#{params[:fromEmail]}>",
         from: "\"#{@name}\"<emailrelay@mailer.henrygd.me>",
         subject: params[:subject] || "New message on #{@site}")
  end
    
end
