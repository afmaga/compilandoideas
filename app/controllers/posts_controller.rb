class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @status = Hash.new
    @comments = @post.comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.published_date = DateTime.now
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.title = (@post.title).capitalize
    @previous_post =  Post.find(:all, :order =>'published_date ASC', :conditions => {:published => 'true'})
    @post.later_post_id = @previous_post.first.id
    @post.author_id = session[:user_id]
    respond_to do |format|
      if @post.save
        @previous_post.first.previous_post_id = @post.id
        @previous_post.first.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    params[:post][:title] = params[:post][:title].split(' ').map {|w| w.capitalize }.join(' ')

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    post = Post.find(params[:id])
    post.deleted = true
    post.published = false
    post.draft = false
    post.programmed = false
    post.save

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def last
    posts =  Post.find(:all, :order =>'published_date ASC', :conditions => {:published => 'true'})
    if posts.is_a?(Array) && posts.size > 0
      @post = posts.first
      @comments = @post.published_comments
    else
      @post = Post.new
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def program
    post = Post.find_by_id(params[:id])
    post.programmed = true   
    post.published_date = params[:date]
    post.save
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

end
