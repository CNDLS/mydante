class SessionsController < ApplicationController

  def destroy
    # p "session #{session.inspect}"
    session["warden.user.user.key"] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
