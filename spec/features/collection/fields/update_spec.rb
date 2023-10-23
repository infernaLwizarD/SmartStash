require 'rails_helper'

RSpec.shared_examples 'edit_collection_field' do
  let_it_be(:item) { create(:collection_item, creator: user) }
  let_it_be(:edited_collection_field) { create(:collection_field, creator: user, item:) }

  it 'успешно редактирует' do
    within('#items-table') do
      expect(page).to have_content(item.label)
      click_link(item.label)
    end

    within('#fields-table') do
      expect(page).to have_content(edited_collection_field.label)
      click_link(edited_collection_field.label)
    end

    click_on 'Редактировать'

    new_label = Faker::Lorem.unique.word
    fill_in 'Наименование', with: new_label

    click_on 'Сохранить'

    expect(page).to have_content 'Поле коллекции отредактировано'
    expect(page).to have_content new_label
  end

  it 'получает сообщение об ошибке не заполнив обязательных полей' do
    within('#items-table') do
      expect(page).to have_content(item.label)
      click_link(item.label)
    end

    within('#fields-table') do
      expect(page).to have_content(edited_collection_field.label)
      click_link(edited_collection_field.label)
    end

    click_on 'Редактировать'

    fill_in 'Наименование', with: ''

    click_on 'Сохранить'

    expect(page).to have_content 'не может быть пустым'
  end
end

RSpec.describe 'Редактирование поля коллекции', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'edit_collection_field'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'edit_collection_field'
  end
end
