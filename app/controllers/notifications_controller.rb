class NotificationsController<ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def index
        @notifications = Notification.where(recipient: current_user).order("created_at DESC")
    end

    def mark_as_read
        @notifications = Notification.where(recipient: current_user)
        @notifications.update_all(read_at: Time.zone.now)
        render json: {:success=> true}
        Notification.delete_read_notification
    end

end