class CommentsController<ApplicationController
    before_action :authenticate_user!
    include NotificationHelper
    
    def create
      @tweet = Tweet.find(params[:tweet_id])
      @comment = @tweet.comments.create(comment_params.merge(user: current_user))

      #create notification for user
      notification=Notification.create(recipient:@tweet.user,actor:current_user,action:"comment",notifiable:@comment)
      NotificationRelayJob.perform_later(notification)

      respond_to do |format|
        if @comment.save
            format.turbo_stream
        else
        flash[:error]="Wrong inputs!! Something is missing"
        render :index
        end
      end
    
      notify(notification)
     # redirect_to tweet_path(@tweet) 
    end
  
    def destroy
        @tweet = Tweet.find(params[:tweet_id])
        @comment = @tweet.comments.find(params[:id])
        @comment.destroy
        redirect_to tweet_path(@tweet), status: 303
    end
  
    def like_comment
      @tweet = Tweet.find(params[:tweet_id])
      @comment = @tweet.comments.find(params[:id])
      current_user.like_comment(@comment)

      respond_to do |format|
        format.turbo_stream
      end
    end

    def recomment
      
      @tweet = Tweet.find(params[:tweet_id])
      @comment = @tweet.comments.find(params[:id])

      @recomment=current_user.comments.new(comment_id:@comment.id,user_id:current_user.id,tweet_id:@comment.tweet_id)
      
      respond_to do |format|
          if @recomment.save
              format.turbo_stream
          else
              format.html{redirect_back fallback_location:@tweet,alert:"Something went wrong while retweeting"}
          end
      end
  end
    private

    def comment_params
      params.require(:comment).permit(:body,:comment_image,:comment_id)
    end
  
end