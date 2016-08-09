class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
    )

    if user
      user.save
      login!(user)
    else
      flash.now[:errors] = ["bad login info"]
      render :new
    end
  end

  def destroy
    logout
  end
end
