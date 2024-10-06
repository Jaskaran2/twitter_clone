module HuggingFace
  class ExtendedInferenceApi < InferenceApi
    def summarization(input:, model: SUMMARIZATION_MODEL, max_length: 150, min_length: 50)
      request connection: connection(model), input: { inputs: input, parameters: { max_length: max_length, min_length: min_length } }
    end
  end
end
