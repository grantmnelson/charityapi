
require 'test_helper'

class ParsePostcardDataWorkerTest < ActiveSupport::TestCase

  def setup

  end

  test "Test that the data was parsed" do
    Sidekiq::Testing.inline!


    filepath = 'test/files/postcard_test.txt'
    ParsePostcardDataWorker.perform_async(filepath)

  end

end
