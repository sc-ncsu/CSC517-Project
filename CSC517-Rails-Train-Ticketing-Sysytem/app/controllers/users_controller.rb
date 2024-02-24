class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :admin_authorized, only: [:index]

      def index
        @users = User.all
      end
    
      def show
      end
    
      def new
        @user = User.new
      end

      def edit
      end

      def create
        @user = User.new(user_params)
    
        respond_to do |format|
          if @user.save
            format.html { redirect_to root_path, notice: "User was successfully created." }
            format.json { render root_path, status: :created, location: @user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @user.update(user_params)
            if current_user && current_user.admin?
              format.html { redirect_to users_path, notice: "User was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { redirect_to root_path, notice: "User was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            end
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @user.destroy
        respond_to do |format|
          if current_user && current_user.admin?
            format.html { redirect_to users_path, notice: "User was successfully destroyed." }
            format.json { head :no_content }
          else
            session[:user_id] = nil
            format.html { redirect_to root_path, notice: "User was successfully destroyed." }
            format.json { head :no_content }
          end
        end
      end

      private
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :address, :phone_number, :credit_number)
      end

      private

      def admin_authorized
        redirect_to root_path unless logged_in? && current_user.admin?
      end
end
