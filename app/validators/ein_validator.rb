class EinValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "EIN must not be nil" if value.nil?
    return if value.nil?
    record.errors.add attribute, "EIN first two digits are invalid" unless valid_ein_prefix?(record)
    record.errors.add attribute, "EIN Must be 9 Digits" unless valid_ein_length?(record)
  end

  # Validates that the ein entered by the user has a known valid prefix.
  def valid_ein_prefix?(record)
    # Data from https://www.irs.gov/Businesses/Small-Businesses-&-Self-Employed/How-EINs-are-Assigned-and-Valid-EIN-Prefixes
    #  Note - these acceptable_prefixes include prefixes that the IRS doesn't include on their database of valid prefixes
    # but actually assigns in practice (according to IRS data dumps)
    acceptable_prefixes = [
     "00", "01", "02", "03", "04", "05", "06", 10, 12, 60, 67, 50, 53, 11, 13, 14, 16, 21, 22, 23,
     25, 34, 51, 52, 54, 55, 56, 57, 58, 59, 65, 30, 32, 35, 36, 37, 38, 61, 15,
     24, 40, 44, 94, 95, 80, 90, 33, 39, 41, 42, 43, 48, 62, 63, 64, 66, 68, 71,
     72, 73, 74, 75, 76, 77, 81, 82, 83, 84, 85, 86, 87, 88, 91, 92, 93, 98, 99,
     20, 26, 27, 45, 46, 47, 31
    ]

    acceptable_prefixes.map! { |p| p.to_s }

    @response = true
    if !acceptable_prefixes.include?(record.ein[0,2])
      @response = false
    end
    @response
  end

  # Must be 9 digits
  def valid_ein_length?(record)
    record.ein.to_s.length != 9 ? false : true
  end

end
