module Api
  def self.do_get_request(params={})
    url = URI.parse(ENV['API_ENDPOINT'].to_s + params[:apicall])
    req = Net::HTTP::Get.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    JSON.parse(response.body) if response
  end
end