class CreateDatasources < ActiveRecord::Migration
  def change
    create_table :datasources do |t|
      t.string :url
      t.datetime :last_scraped
      t.string :name
      t.timestamps null: false
    end
  end
end
