class ProfilesController<ApplicationController
    def show
        @profile = User.find(params[:id])
        @user_tweets = @profile.tweets.all.order("created_at DESC")
    end

    def friendlist
        @profile = User.find(params[:id])
    end

end