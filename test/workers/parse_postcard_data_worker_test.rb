require 'test_helper'

class ParsePostcardDataWorkerTest < ActiveSupport::TestCase

  def setup
    
  end

  test "Test that the data was parsed" do
    Sidekiq::Testing.inline!

  end

end
