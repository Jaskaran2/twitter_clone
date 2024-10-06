class Chat < ApplicationRecord
  belongs_to :user

  def chat_with_user(query)
    context = Tweet.search(query)
    prompt = "You need to only answer based on the following context. In case you do not know the answer just say you don't
      know the answer for the question and user can contact 1800-123-424 for further queries.
      Context: #{context}
      question: #{ query }"

    response = client.question_answering(
        question: query,
        context: prompt
      )

    puts response
  end


  private

  def client
    HuggingFace::InferenceApi.new(api_token: ENV['HUGGING_FACE_AI_TOKEN'])
  end
end