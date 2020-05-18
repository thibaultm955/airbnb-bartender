class CreateBartenders < ActiveRecord::Migration[6.0]
  def change
    create_table :bartenders do |t|
      t.float :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
