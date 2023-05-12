require 'rails_helper'

RSpec.describe 'Создание нового пользователя', js: true, type: :system do
  context 'Администратор' do
    let(:user) { create(:user, :admin) }

    it 'создаёт пользователя' do
      sign_in(login: user.username, password: user.password, visit: true)
      find('li p', text: 'Пользователи').click

      new_password = Faker::Internet.password(min_length: 6)
      click_on 'Добавить', match: :first

      fill_in 'Имя пользователя', with: Faker::Internet.unique.username(separators: %w[_])
      fill_in 'Email', with: Faker::Internet.unique.email
      fill_in 'Пароль', with: new_password
      fill_in 'Подтверждение пароля', with: new_password
      select 'Пользователь', from: 'user[role]'
      click_on 'Сохранить'

      expect(page).to have_content 'Пользователь успешно создан'
    end
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user, :simple_user) }

    it 'не создаёт пользователя' do
      sign_in(login: user.username, password: user.password, visit: true)
      find('li p', text: 'Пользователи').click
      expect(page).to have_css('h1', text: 'Пользователи')
      expect(page).not_to have_content 'Добавить'
    end
  end
end
