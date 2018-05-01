module ApiResponseHelper
  def objects
    JSON.parse(response.body)
  rescue
    []
  end

  def errors
    response.success? ? [] : objects
  end
end
