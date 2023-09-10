module Web::PagyHelper
  def pagy_bootstrap_nav_sm(pagy)
    render('web/shared/pagy_bootstrap_nav_sm', pagy: pagy)
  end
end
