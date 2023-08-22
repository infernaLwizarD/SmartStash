class Web::Collection::ItemsController < Web::ApplicationController
  respond_to :html, :json
  before_action :find_and_authorize_item, except: %i[new create index]

  def index
    authorize Collection::Item

    params[:q] = (params[:q] || {}).merge({ parent_id_null: true })
    @q = policy_scope(Collection::Item).ransack(params[:q])
    @q.sorts = 'sort_order asc' if @q.sorts.empty?
    @pagy, @items = pagy(@q.result)
  end

  def show
    params[:q] = (params[:q] || {}).merge({ parent_id_eq: @item.id })
    @q = policy_scope(Collection::Item).ransack(params[:q])
    @q.sorts = 'sort_order asc' if @q.sorts.empty?
    @pagy, @children = pagy(@q.result)

    respond_with @item
  end

  def new
    authorize Collection::Item

    @item = Collection::Item.new
    respond_with @item
  end

  def edit
  end

  def create
    authorize Collection::Item

    @item = Collection::Item.new(item_params)
    @item.creator_id = current_user.id
    flash[:notice] = 'Коллекция успешно создана' if @item.save
    respond_with @item
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Коллекция отредактирована' if @item.saved_changes?
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if @item.discard
      @item.children.discard_all
      flash[:notice] = 'Коллекция удалена'
    end
    redirect_to collection_items_path
  end

  def restore
    if @item.undiscard
      @item.children.undiscard_all
      flash[:notice] = 'Коллекция восстановлена'
    end
    respond_with @item
  end

  private

  def find_and_authorize_item
    @item = Collection::Item.find(params[:id])
    authorize @item
  end

  def item_params
    attributes = %i[label parent_id sort_order]
    params.require(:collection_item).permit(attributes)
  end
end
