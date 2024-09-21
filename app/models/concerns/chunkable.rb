module Chunkable
  extend ActiveSupport::Concern

  included do
    class << self
      def search(q)
        query_embedding = hugging_face_ai.embed(text: q)
        Chunk.nearest_neighbors(:embeddings, query_embedding.raw_response, distance: 'cosine')
          .first(30)
          .map { |chunk| chunk.chunkable }
          .uniq
          .first(10)
      end

      def hugging_face_ai
        Langchain::LLM::HuggingFace.new(api_key: ENV['HUGGING_FACE_AI_API_KEY'])
      end
    end
  
    def chunk!
      chunks.destroy_all
  
      Langchain::Chunker::RecursiveText.new(
        body,
        chunk_size: 1536,
        chunk_overlap: 200,
        separators: ["\n# ", "\n## ", "\n### "]
      ).chunks.each do |chunk|
        content = chunk.text
        embeddings = hugging_face_ai.embed(text: content)
        chunks.create!(content: content, embeddings: embeddings.raw_response)
      end
    end
  
    def hugging_face_ai
      Langchain::LLM::HuggingFace.new(api_key: ENV['HUGGING_FACE_AI_API_KEY'])
    end
  end
end
