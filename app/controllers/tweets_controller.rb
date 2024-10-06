class TweetsController<ApplicationController

    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token


    def index
        if params[:q].present?
            @tweets = Tweet.search(params[:q])
        else
            @tweets = Tweet.followers_tweets(current_user).recent
        end

        @tweet = current_user.tweets.new
    end

    def show
       @tweet = Tweet.find(params[:id])
       @tweet.set_visitor(current_user) if current_user.id!=@tweet.user.id 
       @replies = Tweet.get_replies(params[:id])
       @count_visited_users = Tweet.find(params[:id]).visiting_users.count
    end

    def create
        @tweet = current_user.tweets.new(tweet_params)

        respond_to do |format|
            if @tweet.save
                format.turbo_stream
                format.html{redirect_back fallback_location: @tweet}
            else
                flash[:error]="Wrong inputs!! Something is missing"
                format.html {render :index}
            end
        end
    end

    def destroy
        @tweet = current_user.tweets.find(params[:id])
        @tweet.destroy
        redirect_to root_path, staus: :no_content    
    end

    def like
        @tweet = Tweet.find(params[:id])
        if current_user.liked_tweets.include?(@tweet)
          current_user.unlike(@tweet)     
        else
          current_user.like(@tweet)
        end
    end


    def retweet
        @tweet = Tweet.find(params[:id])          
        @retweet = current_user.tweets.create(parent_tweet_id: @tweet.id,tweet_type: "retweet")
      
        respond_to do |format|
            if @retweet.save
                format.turbo_stream
                format.html{redirect_back fallback_location: @tweet,notice: "retweet created"}
            else
                format.html{redirect_back fallback_location: @tweet,alert: "Something went wrong while retweeting"}
            end
        end
    end

    def likeables
        @likes= Tweet.find(params[:id]).likes
    end

    def reply
        @tweet = Tweet.find(params[:id])
        @reply = current_user.tweets.create(parent_tweet_id:@tweet.id,body:params[:body],tweet_image: params[:tweet_image],tweet_type: "reply") 

        respond_to do |format|
          if @reply.save
              format.turbo_stream
              format.html{redirect_back fallback_location: @tweet,notice: "reply created"}
          else
              flash[:error]="Wrong inputs!! Something is missing"
              render :index
          end
        end
    end


    def impresseions
        @visited = Tweet.find(params[:id]).visiting_users
    end
    private

    def tweet_params
      params.require(:tweet).permit(:body,:tweet_image,:parent_tweet_id)
    end
end
