class ParseRevokedDataWorker
  include Sidekiq::Worker

  def perform(filepath)
    Organization.parse_revoked_data(filepath)
  end
end
