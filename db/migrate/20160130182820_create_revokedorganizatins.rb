class CreateRevokedorganizatins < ActiveRecord::Migration
  def change
    create_table :revokedorganizations do |t|
      t.string :ein
      t.string :legal_name
      t.string :doing_business_as_name
      t.string :organization_address
      t.string :city
      t.integer :state_id, index: true
      t.string :exemption_type
      t.date :revocation_date
      t.date :revocation_posting_date
      t.date :exemption_reinstatement_date
      t.integer :organization_id, index: true

      t.timestamps null: false
    end
  end
end
