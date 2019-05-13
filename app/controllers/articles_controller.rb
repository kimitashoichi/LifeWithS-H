class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @article.article_images.build
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments
  end

  def edit
  end

  def skate
    @skate_articles = Article.where(genre: 'Skate')
  end

  def hiphop
    @hiphop_articles = Article.where(genre: 'HipHop')
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
  end

  def update
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
