class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy, :show]

  def index
    @articles = Article.all
    render status: 200, json: { articles: @articles }
  end

  def create
    @article = Article.new(article_params)
    @tag_name = article_params[:tag]
    puts @tag_name
    @tag = Tag.find_or_create_by(name: @tag_name)
    @tag_id = @tag.id
    # データベースに保存します
    if @article.save
      @article_id = @article.id
      ArticleTag.create(article_id: @article_id, tag_id: @tag_id)
      render json: { article: @article }, status: :created
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render json: { article: @article }, status: :created
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    puts "@article"
    puts @article
    if @article
      render json: { article: @article }, status: :ok
    else
      render json: { error: "Article not found" }, status: :not_found
    end
  end

  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body, :tag)
  end
end
