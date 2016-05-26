class RelayMailController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :send_mail

  def show
  end

  def send_mail
    # permitted parameters w/ max lengths
    permitted_params = {
      :key       => 50,
      :phone     => 50,
      :email     => 255,
      :name      => 255,
      :fromEmail => 255,
      :subject   => 400,
      :message   => 10000,
      :callback  => 255
    }

    # store callback function or use console.log if missing
    @callback = params[:callback] || "console.log"

    # verify params exist & satisfy length requirements
    permitted_params.each do |key, max_length|
      # force value to string
      if !params[key].is_a? String
        params[key] = params[key].to_s
      end
      # if parameter is empty
      if params[key] == "" || params[key] == "undefined"
        # remove from param hash if param is optional
        if key == :phone || key == :subject
          params.except! key
        # return error if param is not optional
        else
          @message = "Missing #{key} parameter"
          return render :js => %{#{@callback}({"sent":false,"message":"#{@message}"})}
        end
      # ireturn error if param exceeds max length requirement
      elsif params[key].length > max_length
        @message = "#{key} is too long (max #{max_length[key]} characters)"
        return render :js => %{#{@callback}({"sent":false,"message":"#{@message}"})}
      end
    end

    # params good, find user key by email
    user_key = Key.find_by({email: params[:email]})
    # error if user email is not in database
    if !user_key
      @message = "Email not found"
    else
      # error msg if email is found but provided key does not match
      if user_key[:key] != params[:key]
        @message = "Email and key do not match"
      # error msg if user has sent 45 emails already this week
      elsif user_key.sends_week >= 45
        @message = "You have reached the weekly limit"
      # success: send message
      else
        site = URI.parse(request.headers["HTTP_REFERER"]).host
        RelayMailer.relay_mail(params, site).deliver_now
        user_key.sends_all += 1
        user_key.sends_week += 1
        user_key.save
        @sends_left = 45 - user_key.sends_week
        # return success
        return render :js => %{#{@callback}({"sent":true,"remaining":#{@sends_left}})}
      end
    end
    # return
    render :js => %{#{@callback}({"sent":false,"message":"#{@message}"})}
  end

end