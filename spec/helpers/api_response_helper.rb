module ApiResponseHelper
  def response_body
    JSON.parse(response.body)
  end

  def objects
    response_body['data'] || []
  end

  def errors
    response.success? ? [] : response_body['errors']
  end
end
