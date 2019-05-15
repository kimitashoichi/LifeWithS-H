class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :confirm_admin_user, only: [:new, :create, :update, :destroy]

  def new
    @article = Article.new
    @article.article_images.build
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments
    @reply = Reply.new

    if user_signed_in?

      new_history = BrowsingHistory.new
      new_history.user_id = current_user.id
      new_history.article_id = params[:id]

      if current_user.browsing_histories.exists?(article_id: "#{params[:id]}")
        old_history = current_user.browsing_histories.find_by(article_id: "#{params[:id]}")
        old_history.destroy
      end

      new_history.save

      histories_stock_limit = 10
      histories = current_user.browsing_histories.all
      if histories.count > histories_stock_limit
        histories[0].destroy
      end

     end
  end

  def edit
    @article = Article.find(params[:id])
  end

  PER = 10
  def skate
    @skate_articles = Article.where(genre: 'Skate').order(id: :desc).page(params[:page]).per(PER).reverse_order
    if @skate_browse_ranks = @skate_articles.browse_all_ranks.present?
      @skate_browse_ranks = @skate_articles.browse_all_ranks
      @skate_browse_ranks = Kaminari.paginate_array(@skate_browse_ranks).page(params[:page]).per(PER)
    end
  end

  def hiphop
    @hiphop_articles = Article.where(genre: 'HipHop').order(id: :desc).page(params[:page]).per(PER).reverse_order
    if @hiphop_browse_ranks = @hiphop_articles.browse_all_ranks.present?
      @hiphop_browse_ranks = @hiphop_articles.browse_all_ranks
      @hiphop_browse_ranks = Kaminari.paginate_array(@hiphop_browse_ranks).page(params[:page]).per(PER)
    end
  end

  def create
    article = Article.new(article_params)
    article.movie_url = params[:article][:movie_url].gsub('https://www.youtube.com/watch?v=', 'https://www.youtube.com/embed/')
    article.save

    if article.genre == 'Skate'
      redirect_to skate_articles_path
    else
      redirect_to hiphop_articles_path
   end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to skate_articles_path
  end

  def update
    article = Article.find(params[:id])
    article.movie_url = params[:article][:movie_url].gsub('https://www.youtube.com/watch?v=', 'https://www.youtube.com/embed/')
    article.update(article_params)

    if article.genre == 'Skate'
      redirect_to skate_articles_path
    else
      redirect_to hiphop_articles_path
    end
  end

  def confirm_admin_user
    user = current_user
    unless user_signed_in? || user.admin == true
      redirect_to user_path(user.id)
    end
  end

  private

  def article_params
    params.require(:article).permit(
      :movie_url, :article_url, :article_title,
      :article_text, :genre,
      article_images_images: []
    )
  end
end
