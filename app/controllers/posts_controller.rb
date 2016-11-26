class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.all

    render json: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)
    # render json: @posts
  end

  # GET /posts/1
  def show
    post = find_post
    render json: post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    post = find_post
    if post.update(post_params)
      render json: post
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    post = find_post
    post.destroy
    render json: { }, status: :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_post
      Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
