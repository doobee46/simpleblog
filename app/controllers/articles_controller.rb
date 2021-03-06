class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order("published_at desc").page(params[:page]).per_page(5).search(params[:search])
    @recent = Article.recent
    @category = Category.all
    @post_months = @articles.group_by { |t| t.published_at.beginning_of_month }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find_by_slug(params[:id])
    @category = Category.all
    @title = @article.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @category = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find_by_slug(params[:id])
    @category = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(params[:article])
    @category = Category.all

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = current_user.articles.find_by_slug(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = current_user.articles.find_by_slug(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url  }
      format.json { head :no_content }
    end
  end

  

  
end