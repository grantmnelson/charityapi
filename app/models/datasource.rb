class Datasource < ActiveRecord::Base
  # Holds the URL and last checked data for IRS data files we check.


  # Gets the latest versions of the files we parse for important data.
  def self.get_latest
    # Establish Connection to Amazon S3
    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
    })

    # Choose the AWS bucket based on env. Test is also dev.
    Rails.env == 'production' ? bucket = "charityapi" : bucket = "charityapi-dev"

    # Get filename
    @filename = ""

    #
    file = bucket.files.create(
      :key    => 'resume.html',
      :body   => File.open("/path/to/my/resume.html"),
      :public => false
    )


  end

  # The Array of arrays of names and datasource URLs
  def self.sourceurls
    {
      "organizations": "https://apps.irs.gov/pub/epostcard/data-download-pub78.zip",
      "revocations": "https://apps.irs.gov/pub/epostcard/data-download-revocation.zip",
      "990s": "https://apps.irs.gov/pub/epostcard/data-download-epostcard.zip",
      "bmf1": "https://www.irs.gov/pub/irs-soi/eo1.csv",
      "bmf2": "https://www.irs.gov/pub/irs-soi/eo2.csv",
      "bmf3": "https://www.irs.gov/pub/irs-soi/eo3.csv",
      "bmf4": "https://www.irs.gov/pub/irs-soi/eo4.csv"
    }
  end


end
