require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @posts = Post.count
  end

  test "valid post" do
    post = Post.create!(
        {
          post_date: Date.today - 1.months,
          text: "Hello world - unit test",
          link: "mypostunittest.media.com",
          social_media_id: Account.first.social_media_id,
          account_id: Account.first.id
        }
    )
    assert_equal post, Post.last
  end

  test "Invalid post" do
    post = Post.create(
        {
          post_date: Date.today - 1.months,
          link: "heloworld.link",
        }
    )
    assert_equal post.errors.present?, true
  end
end
