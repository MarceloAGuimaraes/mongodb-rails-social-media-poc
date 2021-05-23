require "test_helper"

class ListTest < ActiveSupport::TestCase
  setup do
    @lists = List.count
  end

  test "valid list" do
    List.create!(name: "Test list")
    assert_equal List.count, @lists + 1
  end
end
