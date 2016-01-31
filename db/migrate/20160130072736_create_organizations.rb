class CreateOrganizations < ActiveRecord::Migration
  def up
    unless ActiveRecord::Base.connection.table_exists?(:organizations)
      create_table :organizations do |t|
        t.string :ein
        t.string :legal_name
        t.string :city
        t.integer :state_id, index: true
        t.string :country
        t.string :status
        t.string :irs_code_subsection
        t.string :zip
        t.string :asset_code
        t.string :income_code
        t.integer :asset_amount
        t.integer :income_amount
        t.integer :revenue_990
        t.string :affiliation_code
        t.string :deductibility_code
        t.date :ruling_date
        t.string :affiliation_code
        t.date :last_return
        t.integer :accounting_start
        t.integer :accounting_end
        t.string :organization_code
        t.string :classification_code_1
        t.string :classification_code_2
        t.string :classification_code_3
        t.string :classification_code_4
        t.string :foundation_code_general
        t.string :foundation_code_specific
        t.string :filing_requirement
        t.string :pf_return_requirement
        t.string :activity_code
        t.string :activity_category
        t.string :ntee_category
        t.string :ntee
        t.timestamps null: false
      end

      # Create the _last_checked fields for the database

      fields_to_log = [
        "status",
        "asset_code",
        "income_code",
        "asset_amount",
        "income_amount",
        "revenue_990",
        "affiliation_code",
        "last_return",
        "organization_code",
        "activity_code",
        "activity_category",
        "ntee_category",
        "ntee_sub_category"
      ]

      # Add each one to the table.
      fields_to_log.each do |field|
        add_column :organizations, "#{field.to_s}_last_checked", :datetime, default: Time.now
      end

    end
  end
  def down
    if ActiveRecord::Base.connection.column_exists?(:organizations)
      drop_table :organizations
    end
  end

end
