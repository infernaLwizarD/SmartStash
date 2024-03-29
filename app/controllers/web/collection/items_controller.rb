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
    @pagy_q, @children = pagy(@q.result, page_param: :page_q)

    @f = @item.fields.ransack(params[:f], search_key: :f)
    @f.sorts = 'sort_order asc' if @f.sorts.empty?
    @pagy_f, @fields = pagy(@f.result, page_param: :page_f)

    jstree

    respond_with @item
  end

  def new
    authorize Collection::Item

    @item = Collection::Item.new
    parent = @item.parent || Collection::Item.where(id: params[:parent_id]).first
    parent&.fields&.map { |field| @item.values.build(collection_field_id: field.id) } if parent.present?

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
      @item.descendants.discard_all
      flash[:notice] = 'Коллекция удалена'
    end
    redirect_to @item.root? ? collection_items_path : collection_item_path(@item.parent)
  end

  def restore
    if @item.undiscard
      @item.descendants.undiscard_all
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
    attributes = [:label, :parent_id, :sort_order, {
      values_attributes: %i[id value creator_id collection_item_id collection_field_id file]
    }]
    params.require(:collection_item).permit(attributes)
  end

  def jstree
    @tree_data = []
    calc_levels_cnt

    @item.root&.self_and_descendants&.each do |item|
      is_current = @item == item
      @tree_data.push({
                        id: item.id, parent: item.parent&.id || '#',
                        text: item.label,
                        a_attr: {
                          href: collection_item_url(item),
                          class: item.kept? ? '' : 'discarded'
                        },
                        state: { selected: is_current, opened: is_current }
                      })
    end
  end

  def calc_levels_cnt
    @levels_cnt = 1
    @levels_cnt += @item.find_all_by_generation(1).size
    @item.depth.times do |i|
      generation = i + 1
      @levels_cnt += @item.root&.find_all_by_generation(generation)&.size
    end
  end
end
