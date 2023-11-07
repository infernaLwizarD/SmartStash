module Web::LteHelper
  def lte_button_to(options)
    options[:text] ||= ''
    options[:path] ||= '#'
    options[:class] ||= 'btn-default'

    if options[:method].present?
      link_to(options[:text], options[:path], method: options[:method], class: "btn-sm #{options[:class]}").html_safe
    else
      link_to(options[:text], options[:path], class: "btn-sm #{options[:class]}").html_safe
    end
  end

  def draw_main_title(options = {})
    options[:title] ||= ''
    options[:size] ||= 1

    %(
      <section class="content-header"> \
      <div class="container-fluid"> \
          <div class="row mb-2"> \
              <div class="col-sm-6"> \
                  <h#{options[:size]}>#{options[:title]}</h#{options[:size]}> \
              </div> \
              <div class="col-sm-6"></div> \
          </div> \
      </div> \
      </section> \
    ).html_safe
  end

  def checkbox_val(object, options = {})
    if object.present?
      if options[:yn_format].present?
        'Да'
      else
        '<i class="fas fa-check"></i>'
      end
    elsif options[:yn_format].present?
      'Нет'
    else
      '<i class="fas fa-times"></i>'
    end.html_safe
  end

  def serialized_array(array, options = {})
    options[:prefix] ||= ''
    array&.collect { |i| "#{options[:prefix]}#{i}" }&.join("\n")
  end

  ###--Кнопки--###
  def draw_edit_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    float = options[:float] == 'right' ? ' float-right' : ' float-left'
    link_to(icon('fas', 'edit', 'Редактировать'), options[:path],
            class: "btn-sm ml-1 mr-1 btn-primary#{disabled}#{float}")
  end

  def draw_back_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    float = options[:float] == 'right' ? ' float-right' : ' float-left'
    link_to(icon('fas', 'arrow-left', 'Назад'), options[:path],
            class: "btn-sm ml-1 mr-1 btn-secondary#{disabled}#{float}")
  end

  def draw_delete_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    options[:confirm_text] ||= 'Вы уверены?'
    link_to(icon('fas', 'trash-alt', 'Удалить'),
            options[:path], method: :delete,
                            data: { confirm: options[:confirm_text] },
                            class: "btn-sm btn-danger float-right#{disabled}")
  end

  def draw_save_button(options = {})
    # для кнопки за пределами формы необходимы параметры type="button", onclick="submit()", form="form_name"
    options[:type] ||= 'submit'
    options[:name] ||= 'button'
    form = options[:form].present? ? %( form="#{options[:form]}") : ''
    id = options[:id].present? ? %( id="#{options[:id]}") : ''
    disabled = options[:disabled].present? ? ' disabled' : ''
    onclick = options[:onclick].present? ? %( onclick="#{options[:onclick]}" ) : ''

    out = %(
      <button
        type="#{options[:type]}"
        class="btn-sm border-0 btn-success float-right"#{form}#{id}
        name="#{options[:name]}"#{onclick}#{disabled}>
      <i class="fas fa-save"></i> Сохранить
      </button>
    )
    out.html_safe
  end

  def draw_new_button(options)
    options[:label] ||= 'Добавить'
    options[:bg_class] ||= 'btn-light'
    options[:icon] ||= 'plus'
    disabled = options[:disabled].present? ? ' disabled' : ''

    if options[:button].present?
      %(
      #{link_to(%(
          <button type="button" class="btn btn-sm #{options[:bg_class]}">
            #{icon('fas', options[:icon], options[:label])}
          </button>
        ).html_safe, options[:path])}
      ).html_safe
    else
      link_to(icon('fas', options[:icon], options[:label]), options[:path],
              class: "btn #{options[:bg_class]} btn-sm#{disabled}")
    end
  end
  ###----###
end
