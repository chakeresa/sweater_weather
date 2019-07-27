class ApiService
  def fetch_data(uri_path, params = {})
    response = conn.get uri_path, params
    JSON.parse response.body, symbolize_names: true
  end
end
