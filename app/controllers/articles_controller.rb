class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new; end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    # render json:@article
    @article.save
    redirect_to article_path(@article)
  end
end
