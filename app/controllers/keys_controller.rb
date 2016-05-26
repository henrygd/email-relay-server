class KeysController < ApplicationController

  def create
    email = params[:key][:email].downcase
    respond_to do |format|
      @key = Key.find_by({
        :email => email
      })
      if @key
        format.html {
          flash[:success] = "Key for #{@key.email}: #{@key.key}"
          flash[:notice] = "Total sends: #{@key.sends_all} | This week: #{@key.sends_week}"
          redirect_to root_url
        }
        format.js { render 'key/keyInfo.js'}
      else 
        @key = Key.new({
          :email => email
        })
        if @key.save
          format.html {
            flash[:success] = "Key for #{@key.email}: #{@key.key}"
            redirect_to root_url
          }
          format.js { render 'key/keyInfo.js'}
        else
          format.html {
            flash[:error] = "Error: Please check input"
            redirect_to root_url 
          }
          format.js { render 'key/error.js'}
        end
      end
    end
  end

end