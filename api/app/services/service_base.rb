class ServiceBase
  INTERNAL_ERROR_MESSAGE = "Something went wrong with the service. Please try again after sometime"

  def execute
    initialize_response

    yield
  rescue ::Exceptions::GenericError => e
    error(e.message)
  rescue => e
    raise e unless Rails.env.production?

    error(INTERNAL_ERROR_MESSAGE)
    # Report this error
  end

  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize_response
    @response = Struct.new(:success, :data, :error).new
  end

  def success(data)
    @response.success = true
    @response.data = data

    @response
  end

  def error(error)
    @response.success = false
    @response.error = error

    @response
  end
end
