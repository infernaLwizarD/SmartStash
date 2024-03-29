class Web::Collection::FieldsController < Web::ApplicationController
  respond_to :html, :json
  before_action :find_and_authorize_field, except: %i[new create index]

  def index
    authorize Collection::Field

    @q = policy_scope(Collection::Field).ransack(params[:q])
    @pagy, @fields = pagy(@q.result)
  end

  def show
    respond_with @field
  end

  def new
    authorize Collection::Field

    @field = Collection::Field.new
    respond_with @field
  end

  def edit
  end

  def create
    authorize Collection::Field

    @field = Collection::Field.new(field_params)
    @field.collection_item_id = params[:item_id]
    @field.creator_id = current_user.id
    if @field.save
      flash[:notice] = 'Поле коллекции успешно добавлено'
      redirect_to collection_item_field_path(@field.item, @field)
    else
      respond_with @field.item, @field
    end
  end

  def update
    if @field.update(field_params)
      flash[:notice] = 'Поле коллекции отредактировано' if @field.saved_changes?
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @field.discard
    flash[:notice] = 'Поле коллекции удалено'
    redirect_to collection_item_path(@field.item)
  end

  def restore
    @field.undiscard!
    flash[:notice] = 'Поле коллекции восстановлено'
    redirect_to collection_item_field_path(@field.item, @field)
  end

  private

  def find_and_authorize_field
    @field = Collection::Field.find(params[:id])
    authorize @field
  end

  def field_params
    attributes = %i[label sort_order field_type field_values show_tooltip tooltip is_numeric no_format precision
                    min_value max_value step default_value]
    params.require(:collection_field).permit(attributes)
  end
end
