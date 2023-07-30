require 'rails_helper'

RSpec.shared_examples 'create_item' do
  it 'создаёт Коллекцию' do
    click_on 'Добавить', match: :first

    fill_in 'Наименование', with: Faker::Lorem.unique.word
    click_on 'Сохранить'

    expect(page).to have_content 'Коллекция успешно создана'
  end
end

RSpec.describe 'Создание новой коллекции', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path

    within('.main-sidebar') do
      click_link('Коллекции')
    end
  end

  context 'Администратор' do
    let(:user) { create(:user, :admin) }

    include_examples 'create_item'
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user) }

    include_examples 'create_item'
  end
end
