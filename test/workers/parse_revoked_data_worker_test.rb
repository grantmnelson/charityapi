
require 'test_helper'

class ParseRevokedDataWorkerTest < ActiveSupport::TestCase

  def setup

  end

  test "Test that the data was parsed" do

    Sidekiq::Testing.inline!
    filepath = "test/files/revocation_test.txt"
    ParseRevokedDataWorker.perform_async(filepath)

  end

end
