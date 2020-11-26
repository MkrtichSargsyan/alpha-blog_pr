class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: [:edit,:apdate,:destroy]

  def show; end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # render json:@article

    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to article_path(@article) # @article is the same
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully'
      redirect_to @article
    else
      render 'edit'
      # redirect_to edit_article(@article)
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = 'You can only edit and delete your own article'
      redirect_to @article
    end
  end
end
