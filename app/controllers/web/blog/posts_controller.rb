class Web::Blog::PostsController < Web::ApplicationController
  respond_to :html, :json
  before_action :find_and_authorize_post, except: %i[new create index]

  def index
    authorize Blog::Post

    @q = policy_scope(Blog::Post).ransack(params[:q])
    @pagy, @posts = pagy(@q.result)
  end

  def show
    respond_with @post
  end

  def new
    authorize Blog::Post

    @post = Blog::Post.new
    respond_with @post
  end

  def edit
  end

  def create
    authorize Blog::Post

    @post = Blog::Post.new(post_params)
    @post.creator_id = current_user.id
    flash[:notice] = 'Запись успешно создана' if @post.save
    respond_with @post
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Запись отредактирована' if @post.saved_changes?
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @post.discard
    flash[:notice] = 'Запись удалена'
    redirect_to blog_posts_path
  end

  def restore
    @post.undiscard!
    flash[:notice] = 'Запись восстановлена'
    respond_with @post
  end

  private

  def find_and_authorize_post
    @post = Blog::Post.find(params[:id])
    authorize @post
  end

  def post_params
    attributes = %i[label description message]
    params.require(:blog_post).permit(attributes)
  end
end
