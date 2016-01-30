class CreateOrganizations < ActiveRecord::Migration
  def change
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
      t.timestamps null: false
    end
  end
end
