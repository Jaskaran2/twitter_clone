class Chunk < ApplicationRecord
  belongs_to :chunkable, polymorphic: true
  has_neighbors :embeddings
end
