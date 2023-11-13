require 'rails_helper'

RSpec.shared_examples 'delete_collection_field' do
  let_it_be(:item) { create(:collection_item, creator_id: user.id) }
  let_it_be(:deleting_collection_field) { create(:collection_field, creator: user, item:) }
  let_it_be(:deleted_collection_field) { create(:collection_field, :discarded_collection_field, creator: user, item:) }

  it 'удаляет поле коллекции' do
    within('#items-table') do
      expect(page).to have_content(item.label)
      click_link(item.label)
    end

    within('#fields-table') do
      expect(page).to have_content(deleting_collection_field.label)
      click_link(deleting_collection_field.label)
    end

    accept_confirm do
      click_on 'Удалить'
    end

    expect(page).to have_content 'Поле коллекции удалено'
  end

  it 'восстанавливает поле коллекции' do
    within('#items-table') do
      expect(page).to have_content(item.label)
      click_link(item.label)
    end

    within('#fields-table') do
      expect(page).to have_content(deleted_collection_field.label)
      click_link(deleted_collection_field.label)
    end

    click_on 'Восстановить'

    expect(page).to have_content 'Поле коллекции восстановлено'
  end
end

RSpec.describe 'Удаление поля коллекции', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'delete_collection_field'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'delete_collection_field'
  end
end
