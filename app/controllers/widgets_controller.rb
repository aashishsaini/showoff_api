class WidgetsController < ApplicationController
  def index
    @widgets = Widget.all(params[:term], params[:id], (session[:token] ? session[:token]['access_token'] : nil))
  end

  def new; end

  def create
    url = BASE_URL+ '/api/v1/widgets'
    headers = {'Content-Type': 'application/json', 'Authorization': "Bearer #{session[:token]['access_token']}"}
    payload = {
        "widget": {
            "name": params[:name],
            "description": params[:description],
            "kind": params[:kind]
        }
    }

    response = RestClient.post(url, payload, headers)
    message = JSON.parse(response.body)['message']
    if message == 'Success'
      redirect_to my_widgets_path(id: 'me')
    end
  end

  def edit
    url = BASE_URL+ "/api/v1/widgets/#{params[:id]}"
    headers = {'Content-Type': 'application/json', 'Authorization': "Bearer #{session[:token]['access_token']}"}
    response = RestClient.get(url, headers)
    @widget = JSON.parse(response.body)['data']['widget']
  end

  def update
    url = BASE_URL+ "/api/v1/widgets/#{params[:id]}"
    headers = {'Content-Type': 'application/json', 'Authorization': "Bearer #{session[:token]['access_token']}"}
    payload = {
        "widget": {
            "name": params[:name],
            "description": params[:description]
        }
    }
    response = RestClient.put(url,payload, headers)
    message = JSON.parse(response.body)['message']
    if message == 'Success'
      redirect_to my_widgets_path(id: 'me')
    end
  end

  def destroy
    url = BASE_URL+ "/api/v1/widgets/#{params[:id]}"
    headers = {'Content-Type': 'application/json', 'Authorization': "Bearer #{session[:token]['access_token']}"}
    response = RestClient.delete(url, headers)
    message = JSON.parse(response.body)['message']
    if message == 'Success'
      redirect_to my_widgets_path(id: 'me')
    end
  end
end
