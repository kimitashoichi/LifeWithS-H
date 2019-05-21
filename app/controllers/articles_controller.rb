class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit, :update]
  before_action :confirm_admin_user, only: [:new, :create, :update, :destroy, :edit, :update]

  PER = 10
  def new
    @article = Article.new
    @article.article_images.build
  end

  def admin_article_index
    @all_aritcles = Article.search(params[:search]).order(id: :desc).page(params[:page]).per(PER).reverse_order
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments
    @reply = Reply.new

    # サインインしていれば閲覧履歴を保存する
    if user_signed_in?
      new_history = BrowsingHistory.new
      new_history.user_id = current_user.id
      new_history.article_id = params[:id]
      # 同じページを見た際に重複したものは削除
      if current_user.browsing_histories.exists?(article_id: "#{params[:id]}")
        old_history = current_user.browsing_histories.find_by(article_id: "#{params[:id]}")
        old_history.destroy
      end

      new_history.save
      # 閲覧履歴の保存は最大10件、超えた場合は一番古いものを削除する
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

  # 一覧表示の際に閲覧履歴の多い順で表示するための記述
  def skate
    @skate_articles = Article.where(genre: 'Skate').order(id: :desc).page(params[:page]).per(PER).reverse_order
    if BrowsingHistory.present?
      @skate_browse_ranks = @skate_articles.find(BrowsingHistory.group(:article_id).order('count(article_id) desc').limit(30).pluck(:article_id))
      @skate_browse_ranks = Kaminari.paginate_array(@skate_browse_ranks).page(params[:page]).per(PER)
    end
  end

  def skate_practice
    @skate_practices = Article.where(genre: 'Practice').order(id: :desc).page(params[:page]).per(PER).reverse_order
    if BrowsingHistory.present?
      @skate_practice_browse_ranks = @skate_practices.find(BrowsingHistory.group(:article_id).order('count(article_id) desc').limit(30).pluck(:article_id))
      @skate_practice_browse_ranks = Kaminari.paginate_array(skate_practice_browse_ranks).page(params[:page]).per(PER)
    end
  end

  def hiphop
    @hiphop_articles = Article.where(genre: 'HipHop').order(id: :desc).page(params[:page]).per(PER).reverse_order
    if BrowsingHistory.present?
      @hiphop_browse_ranks = @hiphop_articles.find(BrowsingHistory.group(:article_id).order('count(article_id) desc').limit(30).pluck(:article_id))
      @hiphop_browse_ranks = Kaminari.paginate_array(@hiphop_browse_ranks).page(params[:page]).per(PER)
    end
  end

  def create
    @article = Article.new(article_params)
    @article.movie_url = params[:article][:movie_url].gsub('https://www.youtube.com/watch?v=', 'https://www.youtube.com/embed/')

    if @article.save && @article.genre == 'Practice'
      redirect_to skate_practice_articles_path
    end

    if @article.save! && @article.genre == 'Skate'
      redirect_to skate_articles_path, success: "記事を投稿しました"
    elsif @article.save! && @article.genre == 'HipHop'
      redirect_to hiphop_articles_path, success: "記事を投稿しました"
    else
      flash.now[:danger] = "記事の投稿に失敗しました"
      render :new
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
    unless current_user.admin == true
      redirect_to user_path(current_user.id), danger: "許可されていないアクションです"
    end
  end

  private

  def article_params
    params.require(:article).permit(
      :movie_url, :article_url, :article_title,
      :article_text, :genre,
      :link_name,
      article_images_images: []
    )
  end
end
