class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.bigint :price
      t.integer :price_range
      t.text :details
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
