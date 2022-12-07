require 'rails_helper'
RSpec.describe 'User Show', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Akin',
      bio: 'photographer',
      photo: 'http://passport.com',
      post_counter: 0
    )
    @post1 = Post.create(
      author: @user,
      title: 'My test post',
      text: 'This is my test post',
      comments_counter: 0,
      likes_counter: 0
    )
    @post2 = Post.create(
      author: @user,
      title: 'My second test post',
      text: 'This is my second post',
      comments_counter: 0,
      likes_counter: 0
    )
    @post3 = Post.create(author: @user, title: 'My third test post', text: 'This is my third post',
                         comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(author: @user, title: 'My fourth test post', text: 'This is my fourth post',
                         comments_counter: 0,
                         likes_counter: 0)
  end
  describe 'a user show page' do
    it 'displays the users profile photo' do
      visit user_path(@user)
      expect(page).to have_css("img[src*='http://passport.com']")
    end
  end
  it 'displays the user name' do
    visit user_path(@user)
    expect(page).to have_content('Akin')
  end
  it 'displays the user bio' do
    visit user_path(@user)
    expect(page).to have_content('photographer')
  end
  it 'shows the right Number of posts' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 4')
  end
  it 'shows all the 3 recent posts' do
    visit user_path(@user)
    expect(page).to have_content('My test post')
    expect(page).to have_content('My second test post')
    expect(page).to have_content('My third test post')
    expect(page).to_not have_content('My fourth test post')
  end
  it 'shows a button that helps view all of a users posts' do
    visit user_path(@user)
    expect(page).to have_content('See all posts')
  end
  it 'click to see all posts, it redirects to the users posts index page' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
