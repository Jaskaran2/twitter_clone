class CommentsController<ApplicationController
    before_action :authenticate_user!

    def create
        #post = Post.joins(:comments).first
        @tweet = Tweet.find(params[:tweet_id])
        @comment = @tweet.comments.create(comment_params.merge(user:current_user))
        # @comment.update(user_id:current_user.id)
        redirect_to tweet_path(@tweet) 
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