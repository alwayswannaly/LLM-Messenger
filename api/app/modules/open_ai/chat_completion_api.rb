class OpenAi::ChatCompletionApi

  def initialize
    @api_key = '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'
    @endpoint_url = 'https://api.openai.com/v1/chat/completions'
  end

  def request(prompt, &blk)
    openai_endpoint = URI.parse(@endpoint_url)

    # Create the HTTP request
    request_body = {
      model: 'gpt-3.5-turbo',
      temperature: 1,
      max_tokens: 256,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
      stream: true,
      messages: [
        {
          role: "user",
          content: prompt
        }
      ],
    }

    # Create the HTTP request and process the response as a stream
    http = Net::HTTP.new(openai_endpoint.host, openai_endpoint.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(openai_endpoint.path, request_headers)
    request.body = request_body.to_json

    http.request(request) do |response|
      if response.code.to_i == 200
        response.read_body do |chunk|
          stream_content = parse_from_stream(chunk)
          blk.call(stream_content.join(''))
        end
      else
        # Handle errors
        puts "Failed to make OpenAI request: #{response.code} - #{response.body}"
      end
    end
  end

  private

  def request_headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@api_key}"
    }
  end

  def parse_from_stream(text_stream)
    text_stream.scan(/"content":"(.*?)"/).flatten
  end
end
