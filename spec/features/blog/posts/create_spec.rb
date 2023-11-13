require 'rails_helper'

RSpec.shared_examples 'create_blog_post' do
  it 'создаёт запись' do
    click_on 'Добавить', match: :first

    fill_in 'Заголовок', with: Faker::Lorem.unique.word
    click_on 'Сохранить'

    expect(page).to have_content 'Запись успешно создана'
  end
end

RSpec.describe 'Создание новой записи', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Блог')
    end
  end

  context 'Администратор' do
    let_it_be(:user) { create(:user, :admin) }

    include_examples 'create_blog_post'
  end

  context 'Обычный пользователь' do
    let_it_be(:user) { create(:user) }

    include_examples 'create_blog_post'
  end
end
