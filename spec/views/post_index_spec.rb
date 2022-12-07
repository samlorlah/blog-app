require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Doe John',
      photo: 'http://placeimg.com/640/480/any',
      bio: 'I am a develpoer',
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

    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'Comment 1!')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'Comment 2!')
    Comment.create(post_id: @post2.id, author_id: @user.id, text: 'Comment 3!')

    Like.create(post_id: @post1.id, author_id: @user.id)
    Like.create(post_id: @post2.id, author_id: @user.id)
  end

  describe 'a post index page' do
    it 'displays the user name' do
      visit user_posts_path(@user)
      expect(page).to have_content('Doe John')
    end

    it 'displays the user photo' do
      visit user_posts_path(@user)
      expect(page).to have_css("img[src*='http://placeimg.com/640/480/any']")
    end

    it 'displays total posts by the user' do
      visit user_posts_path(@user)
      expect(page).to have_content('Number of posts: 2')
    end

    it 'can display the post title' do
      visit user_posts_path(@user)
      expect(page).to have_content('My test post')
      expect(page).to have_content('My second test post')
    end

    it 'can see the first post title as' do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.posts.first.title)
    end

    it 'it redirects me to a posts show page when the post is clicked' do
      visit user_posts_path(@user)
      click_link 'My test post'
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end

    it 'can see some of the post body' do
      visit user_posts_path(@user)
      expect(page).to have_content('My test post')
      expect(page).to have_content('My second test post')
      expect(page).to have_content('This is my test post')
      expect(page).to have_content('This is my second post')
    end

    it 'shows how many comments and likes a post has' do
      visit user_posts_path(@user)
      expect(page).to have_content('Comments: 2')
      expect(page).to have_content('Likes: 1')
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 1')
    end

    it 'shows comments in a post' do
      visit user_posts_path(@user)
      expect(page).to have_content('Comment 1!')
      expect(page).to have_content('Comment 2!')
    end
  end
end
