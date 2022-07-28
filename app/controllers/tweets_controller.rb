class TweetsController<ApplicationController

    before_action :authenticate_user!, except:[:index,:show]

    def index
        @tweets = Tweet.all.order("created_at DESC")
        if current_user.nil?
            redirect_to new_user_session_path,notice: "You first need to sign in!!"
        else
        @tweet = current_user.tweets.new
        end
           
    end

    def show
       @tweet= Tweet.find(params[:id])
    end

    def new
        if current_user.nil?
            redirect_to new_user_session_path,notice: "You first need to sign in!!"
        else
        @tweet = current_user.tweets.new
        end
      
    end
    
    def create
        @tweet =current_user.tweets.new(tweet_params)
        
        respond_to do |format|
            if @tweet.save
                format.turbo_stream
            #   redirect_to root_path,notice: "Post created"
            else
            flash[:error]="Wrong inputs!! Something is missing"
            render :new 
            end
        end
    end

    def destroy
        @tweet = current_user.tweets.find(params[:id])
        @tweet.destroy

        redirect_to profile_path, status: 303    
    end

    
    private

    def tweet_params
      params.require(:tweet).permit(:body)
    end

end
