class AddSpecialtyToBartenders < ActiveRecord::Migration[6.0]
  def change
    add_column :bartenders, :specialty, :string, array: true, default: []
  end
end
