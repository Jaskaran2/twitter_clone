class CommentsController<ApplicationController
    before_action :authenticate_user!
    
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

     # redirect_to tweet_path(@tweet) 
    end
  
    def destroy
        @tweet = Tweet.find(params[:tweet_id])
        @comment = @tweet.comments.find(params[:id])
        @comment.destroy
        redirect_to tweet_path(@tweet), status: 303
    end
  
    private

    def comment_params
      params.require(:comment).permit(:body)
    end
  
end