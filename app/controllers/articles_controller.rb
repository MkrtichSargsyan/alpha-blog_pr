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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title,:description))
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
      # redirect_to edit_article(@article)
    end
  end
end
