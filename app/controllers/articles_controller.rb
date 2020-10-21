class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    # render json:@article

    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to article_path(@article) # @article is the same
    else
      render 'new'
    end
  end
end
