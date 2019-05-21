class ResponsesController < ApplicationController
  before_action :authenticate_user!
  # 返信した際に部分テンプレートとして読み込まれるのでReplyの変数も記述している
  def create
    @reply = Reply.new(reply_params)
    @article = Article.find(params[:article_id])
    @comment = @article.comments
    @reply.user_id = current_user.id
    @reply.comment_id = params[:comment_id]
    if @reply.save
      render :index
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @reply = Reply.find_by(params[:article_id])
    if @reply.destroy
      render :index
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:reply_text, :comment_id, :user_id)
  end
end
