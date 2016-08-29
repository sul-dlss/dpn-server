class CreateIngests < ActiveRecord::Migration
  def change
    create_table(:ingests, primary_key: :ingest_id) do |t|
      # t.integer :bag_id, null: false
      t.boolean :ingested, null: false
      t.datetime :created_at, null: false
    end

    add_reference :ingests, :bag, index: true, foreign_key: true

    create_join_table :nodes, :ingests do |t|
      t.index :node_id
      t.index :ingest_id
    end
  end
end
