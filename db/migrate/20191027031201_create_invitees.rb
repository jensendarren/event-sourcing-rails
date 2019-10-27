class CreateInvitees < ActiveRecord::Migration[6.0]
  def change
    create_table :invitees do |t|
      t.string :name
      t.string :email
      t.references :meeting

      t.timestamps
    end
  end
end
