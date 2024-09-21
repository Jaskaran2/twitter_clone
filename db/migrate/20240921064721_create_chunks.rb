class CreateChunks < ActiveRecord::Migration[7.0]
  def change
    create_table :chunks do |t|
      t.references :chunkable, polymorphic: true, null: false
      t.text :content
      t.vector :embeddings, limit: 384

      t.timestamps
    end
  end
end
