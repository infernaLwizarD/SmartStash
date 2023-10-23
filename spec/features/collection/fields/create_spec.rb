require 'rails_helper'

RSpec.shared_examples 'create_collection_field' do
  let_it_be(:item) { create(:collection_item, creator: user) }

  it 'добавляет поле' do
    within('#items-table') do
      expect(page).to have_content(item.label)
      click_link(item.label)
    end

    within('#fields-card') do
      click_on 'Добавить', match: :first
    end

    fill_in 'Наименование', with: Faker::Lorem.unique.word
    select 'Текст', from: 'collection_field[field_type]'
    click_on 'Сохранить'

    expect(page).to have_content 'Поле коллекции успешно добавлено'
  end
end

RSpec.describe 'Добавление нового поля', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'create_collection_field'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'create_collection_field'
  end
end
