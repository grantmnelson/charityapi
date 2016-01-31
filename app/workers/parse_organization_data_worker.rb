class ParseOrganizationDataWorker
  include Sidekiq::Worker

  def perform(filepath)
    options = { :col_sep => "|",
                :chunk_size => 100,
                :headers_in_file => false,
                :convert_values_to_numeric => false,
                :remove_empty_values => false,
                :remove_zero_values => false,
                :verbose => true,
                :user_provided_headers => [
                                          "ein",
                                          "legal_name",
                                          "city",
                                          "state_id",
                                          "country",
                                          "status"
                                        ]


              }
    n = SmarterCSV.process(filepath, options) do |array|
          array.each do |row_hash|
            next if row_hash[:ein].nil? # Skip if the row or hash is empty.
            row_hash[:state_id] = State.find_by_code(row_hash[:state_id]) if row_hash[:country] == "US"


            o = Organization.find_or_initialize_by(ein: row_hash[:ein])
            o.attributes = row_hash
            puts o.attributes
            puts "INVALID" unless o.valid?
            puts "ERRORS:" unless o.valid?
            puts o.errors.inspect unless o.valid?
            o.save!

          end
    end
  end

end
