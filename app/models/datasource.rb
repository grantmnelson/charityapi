class Datasource < ActiveRecord::Base
  # Holds the URL and last checked data for IRS data files we check.


  # Gets the latest versions of the files we parse for important data.
  def self.get_latest
    
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
