class ParseOrganizationDataWorker
  include Sidekiq::Worker

  def perform(filepath)
    Organization.parse_organization_data(filepath)
  end

end
