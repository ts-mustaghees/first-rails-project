class ApplicationController < ActionController::Base
    include SessionsHelper

    private
      def logged_in_user
        unless logged_in?
          store_location 
          flash[:danger] = "Please login first."
          redirect_to login_url
        end 
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user) || admin_user
      end

      def admin_user
        if !current_user.admin?
          flash[:danger] = "Unauthorized to perform deletion."
          redirect_to users_path
        end

        true
      end
end
