require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(
    name: 'John',
    photo: 'http://example-photo.com',
    post_counter: 0
  )

  post = Post.create(
    title: 'Title',
    text: 'Post text and story',
    comments_counter: 0,
    likes_counter: 0,
    author_id: user.id
  )

  5.times.collect do
    Comment.create(
      post: post, author: user,
      text: 'Long text for comment'
    )
  end

  context 'five_recent_comments' do
    it 'return at most 5 comments' do
      expect(post.five_recent_comments.length).to be_between(0, 5).inclusive
    end

    it 'should return 5 comments' do
      expect(post.five_recent_comments.length).to eql(5)
    end
  end

  context 'update_post_counter' do
    it 'should update comment counter by 1' do
      expect(User.find(user.id).post_counter).to eq(user.post_counter + 1)
    end
  end
end
