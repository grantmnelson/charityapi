class ScrapeBmfDataWorker.rb
  include Sidekiq::Worker

  # The perform() method is called regularly to collect and combine the data that
  # the IRS publishes in the Exempt Organizations Business Master File (EOBMF)

  # Do Not rename the method from perform. You can define more methods below.
  def perform()

  end

end
