class SummarizeTweetJob < ApplicationJob
  queue_as :default

  def perform(text, max, min, id)
    tweet = Tweet.find_by(id: id)

    client = HuggingFace::ExtendedInferenceApi.new(api_key: ENV['HUGGING_FACE_AI_API_KEY'])
    tweet_summary = if max.present? || min.present?
        client.summarization(input: text, max_length: max, min_length: min)
      else
        client.summarization(input: text)
      end

    tweet.summary = tweet_summary
    tweet.save
  end
end