class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.uuid :entity_id
      t.datetime :time
      t.integer :organizer_id

      t.timestamps
    end
  end
end
