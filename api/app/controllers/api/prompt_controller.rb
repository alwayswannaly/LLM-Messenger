class Api::PromptController < ::ApplicationController
  def index
    render json: { hello: "world" }
  end
end
