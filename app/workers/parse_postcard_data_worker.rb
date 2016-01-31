class ParsePostcardDataWorker
  include Sidekiq::Worker

  # The perform() method is called regularly to collect and combine the data that
  # the IRS publishes in the ePostcard file online.

  # Do Not rename the method from perform. You can define more methods below.
  def perform()

  end

end
