require 'test_helper'

class PostcardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "fixtures are valid" do
    Postcard.find_each do |o|
      assert o.valid?
    end
  end
end
