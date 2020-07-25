class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :date
      t.integer :creator_id, null: false
      t.timestamps
    end
  end
end
