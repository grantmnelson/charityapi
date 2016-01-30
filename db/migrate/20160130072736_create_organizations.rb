class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :ein
      t.string :legal_name
      t.string :city
      t.integer :state_id, index: true
      t.string :country
      t.string :status

      t.timestamps null: false
    end
  end
end
