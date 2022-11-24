require 'rails_helper'

RSpec.describe Like, type: :model do
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

  like = Like.create(post: post, author: user)

  context 'update_likes_counter' do
    like.update_likes_counter

    it ' increment likes_counter' do
      expect(Post.find(post.id).likes_counter).eql?(post.likes_counter + 1)
    end
  end
end
