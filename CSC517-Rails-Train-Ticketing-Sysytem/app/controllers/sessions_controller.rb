class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email_address(params[:email_address])
    if @user  && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash.now[:error] = "Invalid email or password. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
