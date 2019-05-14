class CommentsController < ApplicationController
  def create
  	@article = Article.find(params[:article_id])
  	@comment = @article.comments.build(comment_params)
  	@comment.user_id = current_user.id
  	if @comment.save
      @reply = Reply.new
  		render :index
  	end
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	if @comment.destroy
  		render :index
  	end
  end

  private
  def comment_params
  	params.require(:comment).permit(:comment_text, :article_id, :user_id)
  end
end
