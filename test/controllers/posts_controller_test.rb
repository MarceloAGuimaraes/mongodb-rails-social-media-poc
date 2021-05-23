require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Person.create!([
      {
        name: "First person"
      },
      {
        name: "Second person"
      }
    ])
    SocialMedia.create!([
      {
        name: "Social media - First"
      },
      {
        name: "Social media - Second"
      },
    ])
    List.create!({
      name: "List One",
      persons: Person.all.to_a
    })
    Account.create!([
      {
        email: "firstperson@media.com",
        person_id: Person.first.id,
        social_media: SocialMedia.first.id
      },
      {
        email: "firstperson@media2.com",
        person_id: Person.first.id,
        social_media: SocialMedia.last.id
      },
      {
        email: "secondperson@media.com",
        person_id: Person.last.id,
        social_media: SocialMedia.last.id
      },
    ])
    i = 0
    10.times do
      Post.create(
        {
          post_date: Date.today - i.months,
          text: "Hello world #{i}",
          link: "mypost#{i}.media.com",
          social_media_id: Account.first.social_media_id,
          account_id: Account.first.id
        }
      )
      i += 1
    end

    i = 0
    10.times do
      Post.create(
        {
          post_date: Date.today - (i.months + 2),
          text: "Hello world #{i}",
          link: "mypost#{i}.media.com",
          social_media_id: Account.last.social_media_id,
          account_id: Account.last.id
        }
      )
      i += 1
    end
  end

  test "should get index without filters" do
    get posts_url
    assert_response :success
  end

  test "should get index with date range filter" do
    get posts_url, params: { date_range: { min: (Date.today - 2.months), max: Date.today } }
    assert_response :success
  end

  test "should get index with network filter" do
    network = SocialMedia.find_by(name: "Social media - First")
    get posts_url, params: { network: network.id }
    assert_response :success
  end

  test "should get index with text filter" do
    get posts_url, params: { text: "Hello World 0" }
    assert_response :success
  end
end
