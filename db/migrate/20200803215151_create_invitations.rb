class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :host, null: false, index: true, foreign_key: {to_table: :users}
      t.references :invitee, null: false, index: true, foreign_key: {to_table: :users}
      t.references :event, null: false, foreign_key: true
      t.string :status, null: false
      t.timestamps
    end
    add_index :invitations, [:host_id, :invitee_id, :event_id], unique: true
  end
end
