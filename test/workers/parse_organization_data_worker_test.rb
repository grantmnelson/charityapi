require 'test_helper'

class ParseOrganizationDataWorkerTest < ActiveSupport::TestCase

  test "smoke test parses data" do
    Sidekiq::Testing.inline!
    filepath = 'test/files/exempt_organizations_test.txt'
    ParseOrganizationDataWorker.perform_async(filepath)
  end

end
