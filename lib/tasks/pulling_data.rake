task :get_data => :environment do

  if Rails.env == 'production'
    organizations_text = "https://s3.amazonaws.com/charityapi-irsdata/exempt_organizations_full.txt"
    postcard_text = "https://s3.amazonaws.com/charityapi-irsdata/postcard_full.txt"
    revocation_text = "https://s3.amazonaws.com/charityapi-irsdata/data-download-revocation.txt"
    # postcard_text = "https://apps.irs.gov/pub/epostcard/data-download-epostcard.zip"
    # revoked_text = "https://apps.irs.gov/pub/epostcard/data-download-revocation.zip"

    # The regional pieces of the BMF
    regional_urls = [
      "https://www.irs.gov/pub/irs-soi/eo1.csv",
      "https://www.irs.gov/pub/irs-soi/eo2.csv",
      "https://www.irs.gov/pub/irs-soi/eo3.csv",
      "https://www.irs.gov/pub/irs-soi/eo4.csv"
    ]

  else
    organizations_text = "test/files/exempt_organizations_test.txt"
    postcard_text = "test/files/postcard_test.txt"
    revocation_text = "test/files/revocation_test.txt"

    regional_urls = [
      "test/files/bmf_test.csv"
    ]
  end

  # First Get Organizations
  Organization.parse_organization_data(organizations_text)

  # Then Get Regional EO BMF Data & merge it in.
  regional_urls.each do |url|
    Organization.parse_bmf_data(url)
  end

  # Parse revoked data
  Organization.parse_revoked_data(revocation_text)

  # Parse Postcard data
  Postcard.parse_postcard_data(postcard_text)

end

task :demo_data => :environment do

  if Rails.env == "production"
    organizations_text = "exempt_organizations_test.txt"
    postcard_text = "postcard_test.txt"
    revocation_text = "revocation_test.txt"
    regional_url = "bmf_test.csv"
  else
    organizations_text = "test/files/exempt_organizations_test.txt"
    postcard_text = "test/files/postcard_test.txt"
    revocation_text = "test/files/revocation_test.txt"
    regional_url = "test/files/bmf_test.csv"
  end

  # First Get Organizations
  Organization.parse_organization_data(organizations_text)

  # Then Get Regional EO BMF Data & merge it in.
  Organization.parse_bmf_data(regional_url)

  # Parse revoked data
  Organization.parse_revoked_data(revocation_text)

  # Parse Postcard data
  Postcard.parse_postcard_data(postcard_text)
end
