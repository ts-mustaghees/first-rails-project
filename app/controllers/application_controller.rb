class ApplicationController < ActionController::Base
    include SessionsHelper

    private
      def admin_user
        if !current_user.admin?
          flash[:danger] = "Unauthorized to perform deletion."
          redirect_to users_path
        end

        true
      end
end
