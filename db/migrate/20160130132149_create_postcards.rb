class CreatePostcards < ActiveRecord::Migration
  def change
    create_table :postcards do |t|
      t.string :ein
      t.integer :tax_year
      t.string :organization_name
      t.boolean :gross_reciepts_under_25k
      t.boolean :terminated
      t.date :tax_period_begin_date
      t.date :tax_period_end_date
      t.string :website_url
      t.string :officer_name
      t.string :officer_address_line_1
      t.string :officer_address_line_2
      t.string :officer_address_city
      t.string :officer_address_province
      t.references :officer_address_state, index: true
      t.string :officer_address_postal_code
      t.string :officer_address_country
      t.string :organization_address_line_1
      t.string :organization_address_line_2
      t.string :organization_address_city
      t.string :organization_address_province
      t.references :organization_address_state, index: true
      t.string :organization_address_postal_code
      t.string :organization_address_country
      t.string :doing_business_as_name_1
      t.string :doing_business_as_name_2
      t.string :doing_business_as_name_3
      t.references :organization, index: true

      t.timestamps null: false
    end
  end
end
