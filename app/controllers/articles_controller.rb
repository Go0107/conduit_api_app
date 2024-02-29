class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render status: 200, json: { articles: @articles }
  end

  def create
    @article = Article.new(article_params)
    # データベースに保存します
    if @article.save
      render json: { article: @article }, status: :created
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
