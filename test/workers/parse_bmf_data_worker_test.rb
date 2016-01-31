require 'test_helper'

class ParseBmfDataWorkerTest < ActiveSupport::TestCase

  def setup

  end

  test "Test that the data was parsed" do
    Sidekiq::Testing.inline!
    filepath = "test/files/bmf_test.csv"
    ParseBmfDataWorker.perform_async(filepath)
  end

end
