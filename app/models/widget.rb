class Widget

  def self.all(term=nil, id=nil, bearer=nil, my_view=false)
    # get  all visible widgets
    url = "#{BASE_URL}/api/v1/widgets/visible?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"
    headers = {'Content-Type': 'application/json'}

    #get user specific widgets
    if id
      url = "#{BASE_URL}/api/v1/users/#{id}/widgets?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"
      headers = {'Authorization': "Bearer #{bearer}"}
    end

    # get logged in user widget
    if my_view
      url = "#{BASE_URL}/api/v1/widgets"
      headers = {'Authorization': "Bearer #{bearer}"}
    end

    #search widget
    (url = url + "&term=#{term}") if term

    #parse result
    response = RestClient.get(url, headers)
    data = JSON.parse(response.body)['data']['widgets']
    data
  end
end