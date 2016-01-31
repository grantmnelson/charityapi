class CreateRevokedorganizatins < ActiveRecord::Migration
  def up
    unless ActiveRecord::Base.connection.table_exists?(:revokedorganizations)
      create_table :revokedorganizations do |t|
        t.string :ein
        t.string :legal_name
        t.string :doing_business_as_name
        t.string :organization_address
        t.string :city
        t.string :zip
        t.string :country
        t.integer :state_id, index: true
        t.string :exemption_type
        t.date :revocation_date
        t.date :revocation_posting_date
        t.date :exemption_reinstatement_date
        t.integer :organization_id, index: true

        t.timestamps null: false
      end

      fields_to_log = [
        "city",
        "legal_name",
        "exemption_type",
        "revocation_date",
        "revocation_posting_date",
        "exemption_reinstatement_date"
      ]

      # Add each one to the table.
      fields_to_log.each do |field|
        add_column :revokedorganizations, "#{field.to_s}_last_checked", :datetime, default: Time.now
      end

    end
  end
  def down
    if ActiveRecord::Base.connection.table_exists?(:revokedorganizations)
      drop_table :revokedorganizations
    end
  end
end
