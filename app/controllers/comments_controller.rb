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
  
      #redirect_to tweet_path(@tweet)
    end
    private

    def comment_params
      params.require(:comment).permit(:body,:comment_image)
    end
  
end