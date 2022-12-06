require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Doe John',
      photo: 'http://placeimg.com/640/480/any',
      bio: 'I am a develpoer',
      post_counter: 0
    )

    @user2 = User.create(
      name: 'Doe makinde',
      photo: 'http://placeimg.com/640/450/any',
      bio: 'I am an engineer',
      post_counter: 0
    )

    @post = Post.create(
      author: @user1,
      title: 'My test post',
      text: 'This is my test post',
      comments_counter: 0,
      likes_counter: 0
    )

    Comment.create(post_id: @post.id, author_id: @user1.id, text: 'Comment 1!')
    Comment.create(post_id: @post.id, author_id: @user1.id, text: 'Comment 2!')
    Comment.create(post_id: @post.id, author_id: @user1.id, text: 'Comment 3!')
    Comment.create(post_id: @post.id, author_id: @user2.id, text: 'Comment 4!')
    Comment.create(post_id: @post.id, author_id: @user2.id, text: 'Comment 5!')

    Like.create(post_id: @post.id, author_id: @user1.id)
    Like.create(post_id: @post.id, author_id: @user2.id)
  end

  describe 'A specific post with title, comments and counter' do
    it 'displays the post title' do
      visit user_post_path(@user1, @post)
      expect(page).to have_content('My test post')
    end

    it 'displays the post title and user who wrote the post' do
      visit user_post_path(@user1, @post)
      expect(page).to have_content('My test post By Doe John')
    end

    it 'displays total comments and likes' do
      visit user_post_path(@user1, @post)
      expect(page).to have_content('Comments: 5, Likes: 2')
    end

    it 'shows other parts of the post body' do
      visit user_post_path(@user1, @post)
      expect(page).to have_content('This is my test post')
    end

    it 'shows the comment text' do
      visit user_post_path(@user1, @post)
      expect(page).to have_content('Comment 1!')
      expect(page).to have_content('Comment 2!')
      expect(page).to have_content('Comment 3!')
    end
  end
end