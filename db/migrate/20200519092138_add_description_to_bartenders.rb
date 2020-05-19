class AddDescriptionToBartenders < ActiveRecord::Migration[6.0]
  def change
    add_column :bartenders, :description, :string, :default => ""
  end
end
