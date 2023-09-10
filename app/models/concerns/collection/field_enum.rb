module Collection::FieldEnum
  extend ActiveSupport::Concern

  included do
    enum field_type: {
      text: 'text',
      textarea: 'textarea',
      select: 'select',
      date: 'date',
      checkbox: 'checkbox',
      radio: 'radio',
      file: 'file'
    }, _suffix: true
  end

  FIELD_TYPE_LABEL_BY_CODE = {
    'text' => 'Текст',
    'textarea' => 'Многострочный текст',
    'select' => 'Список',
    'date' => 'Дата',
    'checkbox' => 'Чекбокс',
    'radio' => 'Радиокнопка',
    'file' => 'Файл'
  }.freeze

  class_methods do
    def field_type_collection
      FIELD_TYPE_LABEL_BY_CODE.keys.collect { |i| [FIELD_TYPE_LABEL_BY_CODE[i], i] }
    end
  end

  def field_type_label
    FIELD_TYPE_LABEL_BY_CODE.fetch(field_type, '')
  end
end
