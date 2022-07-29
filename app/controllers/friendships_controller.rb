class FriendshipsController<ApplicationController
    before_action :authenticate_user!
    before_action :find_user

    def create
        current_user.follow(@user)
        puts current_user.following?(@user)
        redirect_to profile_path(@user)
    end

    def destroy
        current_user.unfollow(@user)
        redirect_to profile_path(@user)
    end

    private
    def find_user
        @user=User.find(params[:profile_id])
    end
end