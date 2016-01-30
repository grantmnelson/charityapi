class CreateRevokedOrganizations < ActiveRecord::Migration
  def change
    create_table :revoked_organizations do |t|
      t.string :ein
      t.string :legal_name
      t.string :doing_business_as_name
      t.string :organization_address
      t.string :city
      t.references :state, index: true
      t.string :exemption_type
      t.date :revocation_date
      t.date :revocation_posting_date
      t.date :exemption_reinstatement_date
      t.references :organization, index: true

      t.timestamps null: false
    end
  end
end
