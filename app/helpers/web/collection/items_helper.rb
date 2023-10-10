module Web::Collection::ItemsHelper
  def field_by_type(values_form)
    case values_form.object.field.field_type
    when 'text'
      values_form.text_field(:value, class: 'form-control form-control-sm')
    when 'textarea'
      rows = values_form.object.value&.split(/[\r\n]+/)&.compact&.size
      values_form.text_area(:value, rows:, class: 'form-control form-control-sm')
    when 'select'
      values_form.select(:value, values_form.object.field.field_values,
                         { include_blank: '[Выберите]' },
                         class: 'form-control form-control-sm')
    when 'date'
      values_form.date_field(:value, class: 'form-control form-control-sm', value: values_form.object.value)
    when 'checkbox'
      values_form.check_box(:value, class: 'checkbox-field')
    when 'radio'
      values_form.collection_radio_buttons(:value,
                                           values_form.object.field.field_values.collect { |i| [i, i] },
                                           :first, :second) do |item|
        item.label(class: 'row ml-2 font-weight-normal') do
          "#{item.radio_button(class: 'mr-2')} #{item.text}".html_safe
        end
      end
    when 'file'
      values_form.file_field(:file, class: 'form-control form-control-sm')
    end
  end

  def value_by_type(value)
    case value.field.field_type
    when 'file'
      if value.file.attached?
        link_to(value.file&.filename, rails_blob_path(value.file, disposition: 'attachment'))
      else
        ''
      end
    else
      value.value
    end
  end
end
