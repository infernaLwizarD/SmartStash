require 'rails_helper'

RSpec.shared_examples 'edit_blog_post' do
  let_it_be(:edited_post) { create(:blog_post, creator: user) }

  it 'успешно редактирует' do
    within('#posts-table') do
      expect(page).to have_content(edited_post.label)
      click_link(edited_post.label)
    end

    click_on 'Редактировать'

    new_label = Faker::Lorem.unique.word
    fill_in 'Заголовок', with: new_label

    click_on 'Сохранить'

    expect(page).to have_content 'Запись отредактирован'
    expect(page).to have_content new_label
  end

  it 'получает сообщение об ошибке не заполнив обязательных полей' do
    within('#posts-table') do
      expect(page).to have_content(edited_post.label)
      click_link(edited_post.label)
    end

    click_on 'Редактировать'

    fill_in 'Заголовок', with: ''

    click_on 'Сохранить'

    expect(page).to have_content 'не может быть пустым'
  end
end

RSpec.describe 'Редактирование Запись', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Блог')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'edit_blog_post'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'edit_blog_post'
  end
end
