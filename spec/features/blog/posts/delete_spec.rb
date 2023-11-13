require 'rails_helper'

RSpec.shared_examples 'delete_blog_post' do
  let_it_be(:deleting_post) { create(:blog_post, creator: user) }
  let_it_be(:deleted_post) { create(:blog_post, :discarded_blog_post, creator: user) }

  it 'удаляет запись' do
    within('#posts-table') do
      expect(page).to have_content(deleting_post.label)
      click_link(deleting_post.label)
    end

    accept_confirm do
      click_on 'Удалить'
    end

    expect(page).to have_content 'Запись удалена'
  end

  it 'восстанавливает запись' do
    within('#posts-table') do
      expect(page).to have_content(deleted_post.label)
      click_link(deleted_post.label)
    end

    click_on 'Восстановить'

    expect(page).to have_content 'Запись восстановлена'
  end
end

RSpec.describe 'Удаление записи', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Блог')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'delete_blog_post'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'delete_blog_post'
  end
end
