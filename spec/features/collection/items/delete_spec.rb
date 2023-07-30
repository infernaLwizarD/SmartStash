require 'rails_helper'

RSpec.shared_examples 'delete_item' do
  let_it_be(:deleting_item) { create(:collection_item, creator_id: user.id) }
  let_it_be(:deleted_item) { create(:collection_item, :discarded, creator_id: user.id) }

  it 'удаляет коллекцию' do
    within('#items-table') do
      expect(page).to have_content(deleting_item.label)
      click_link(deleting_item.label)
    end

    accept_confirm do
      click_on 'Удалить'
    end

    expect(page).to have_content 'Коллекция удалена'
  end

  it 'восстанавливает коллекцию' do
    within('#items-table') do
      expect(page).to have_content(deleted_item.label)
      click_link(deleted_item.label)
    end

    click_on 'Восстановить'

    expect(page).to have_content 'Коллекция восстановлена'
  end
end

RSpec.describe 'Удаление коллекции', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'delete_item'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'delete_item'
  end
end
