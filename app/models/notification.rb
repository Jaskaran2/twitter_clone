class Notification < ApplicationRecord
    belongs_to :recipient,class_name:"User"
    belongs_to :actor,class_name:"User"
    belongs_to :notifiable,polymorphic: true 

    scope :delete_read_notification,->{ where.not(read_at: nil).delete_all }
end
