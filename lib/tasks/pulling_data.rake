task :get_data => :environment do

  organizations_full_text = "https://s3.amazonaws.com/charityapi-irsdata/exempt_organizations_full.txt"
  postcard_full_text = "https://s3.amazonaws.com/charityapi-irsdata/postcard_full.txt"

  if Rails.env == 'production'
    organizations_text = "https://s3.amazonaws.com/charityapi-irsdata/exempt_organizations_full.txt"
    postcard_text = "https://s3.amazonaws.com/charityapi-irsdata/postcard_full.txt"

    # The regional pieces of the BMF
    regional_urls = [
      "https://www.irs.gov/pub/irs-soi/eo1.csv",
      "https://www.irs.gov/pub/irs-soi/eo2.csv",
      "https://www.irs.gov/pub/irs-soi/eo3.csv",
      "https://www.irs.gov/pub/irs-soi/eo4.csv"
    ]

  else
    organizations_text = "test/files/organization_data.txt"
    postcard_text = "test/files/postcard_data.txt"

    regional_urls = [
      "test/files/bmf_test.csv"
    ]
  end

  # First Get Organizations
  Organization.parse_organization_data(organizations_text)

  # Then Get Regional EO BMF Data & merge it in.
  regional_urls.each do |url|
    Organization.parse_bmf_data(filepath)
  end

  


end
