class AddFieldsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :title, :string, null: false
    add_column :events, :location, :string
    add_column :events, :accessibility, :boolean, null: false, default: false
  end
end
