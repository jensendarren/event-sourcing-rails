class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table 'events', id: :serial do |t|
      t.uuid 'entity_id', null: false, index: true

      t.string 'entity_type', null: false
      t.string 'event_type', null: false
      t.integer 'entity_version', null: false

      # t.jsonb 'meta', null: false
      t.jsonb 'data', null: false
      t.datetime 'created_at', null: false

      t.index ['entity_id', 'entity_version'], name: 'event_version_constraint', unique: true
    end
  end
end
