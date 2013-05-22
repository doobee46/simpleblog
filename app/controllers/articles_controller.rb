class ArticlesController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  REDACTOR_TAGS = %w(code span div label a br p b i del strike u img video audio
                  iframe object embed param blockquote mark cite small ul ol li
                  hr dl dt dd sup sub big pre code figure figcaption strong em
                  table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)
  REDACTOR_ATTRIBUTES = %w(href)

  # ...


  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order("published_at desc").page(params[:page]).per_page(5).search(params[:search])
    @recent = Article.recent
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
    @article = Article.find_by_slug(params[:id])
    @category = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
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
    @article = Article.find_by_slug(params[:id])

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
    @article = Article.find_by_slug(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url  }
      format.json { head :no_content }
    end
  end

  

  
end