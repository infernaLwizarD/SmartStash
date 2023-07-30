require 'rails_helper'

RSpec.shared_examples 'edit_item' do
  let_it_be(:edited_item) { create(:collection_item, creator_id: user.id) }

  it 'успешно редактирует' do
    within('#items-table') do
      expect(page).to have_content(edited_item.label)
      click_link(edited_item.label)
    end

    click_on 'Редактировать'

    new_label = Faker::Lorem.unique.word
    fill_in 'Наименование', with: new_label

    click_on 'Сохранить'

    expect(page).to have_content 'Коллекция отредактирована'
    expect(page).to have_content new_label
  end

  it 'получает сообщение об ошибке не заполнив обязательных полей' do
    within('#items-table') do
      expect(page).to have_content(edited_item.label)
      click_link(edited_item.label)
    end

    click_on 'Редактировать'

    fill_in 'Наименование', with: ''

    click_on 'Сохранить'

    expect(page).to have_content 'не может быть пустым'
  end
end

RSpec.describe 'Редактирование коллекции', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'edit_item'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'edit_item'
  end
end
