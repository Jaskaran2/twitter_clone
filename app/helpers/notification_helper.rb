module NotificationHelper
    def notify(notification)
        Turbo::StreamsChannel.broadcast_replace_later_to "notification_bell",
                                target:"#{notification.recipient.id}_notification_bell_icon",
                                partial:"shared/bellnotification"
                               
    end

end