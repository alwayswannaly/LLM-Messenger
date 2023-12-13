class Api::PromptController < ::ApplicationController
  include ActionController::Live

  def index
    render json: { hello: "world" }
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate
    sse = SSE.new(response.stream, retry: 300, event: "open")

    client = OpenAi::ChatCompletionApi.new
    client.request(params[:prompt]) do |stream|
      sse.write({ name: stream }, event: "message")
    end

  rescue ActionController::Live::ClientDisconnected
    sse.close
  ensure
    sse.close
  end
end
