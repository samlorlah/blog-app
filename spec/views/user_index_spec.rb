require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Akin',
      bio: 'photographer',
      photo: 'http://passport.com',
      post_counter: 5
    )

    @user2 = User.create(
      name: 'Maggie',
      bio: 'stylist',
      photo: 'http://photo.com',
      post_counter: 2
    )
  end

  describe 'users index page' do
    it 'shows the right username' do
      visit users_path
      expect(page).to have_content('Akin')
      expect(page).to have_content('Maggie')
      expect(page).to_not have_content('john')
    end

    it 'shows the right photo' do
      visit users_path
      expect(page).to have_css("img[src*='http://passport.com']")
      expect(page).to have_css("img[src*='http://photo.com']")
    end

    it 'shows the right Number of posts' do
      visit users_path
      expect(page).to have_content('Number of posts: 5')
      expect(page).to have_content('Number of posts: 2')
    end

    it 'shows the user_path when clicked' do
      visit users_path
      click_link 'Akin'
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
