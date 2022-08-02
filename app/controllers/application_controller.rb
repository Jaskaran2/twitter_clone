class ApplicationController < ActionController::Base
    before_action :set_current_user, if: :user_signed_in?
    
    private
    def set_current_user
      Current.user = current_user
    end

    def get_current_notifications
      @notifications=Notification.where(recipient: current_user).unread
      Current.user.notifications=@notifications
    end

end
