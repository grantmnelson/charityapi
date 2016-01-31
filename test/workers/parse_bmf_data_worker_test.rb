require 'test_helper'

class ParseBmfDataWorkerTest < ActiveSupport::TestCase

  def setup
    
  end

  test "Test that the data was parsed" do
    Sidekiq::Testing.inline!

  end

end
