class UsersController < ApplicationController
  def create
    url = BASE_URL+ '/oauth/token'
    payload = {
        "grant_type": "password",
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "username": params[:email],
        "password": params[:password]
    }
    begin
      headers = {'Content-Type': 'application/json'}
      response = RestClient.post(url, payload, headers)
      data = JSON.parse(response.body)['data']
      session[:token] = data['token']
      get_user
      redirect_to root_url
    rescue
      redirect_to root_url
    end
  end

  def destroy
    session[:token] = nil
    session[:user] = nil
    redirect_to root_url
  end

  def login; end
  def sign_up; end
  def reset_password; end

  def register
    url = BASE_URL + "/api/v1/users"
    headers = {'Content-Type': 'application/json'}
    payload = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "user": {
            "first_name": params[:first_name],
            "last_name": params[:last_name],
            "email": params[:email],
            "password": params[:password],
            "image_url": params[:image_url] || 'https://static.thenounproject.com/png/961-200.png'
        }
    }
    begin
      response = RestClient.post(url, payload, headers)
      data = JSON.parse(response.body)['data']
      session[:token] = data['token']
      session[:user] = data['user']
      redirect_to root_url
    rescue
      redirect_to root_url
    end
  end

  def password_reset
    url = BASE_URL + "/api/v1/users/reset_password"
    headers = {'Content-Type': 'application/json'}
    payload = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "user": {
            "email": params[:email]
        }
    }
    begin
      response = RestClient.post(url, payload, headers)
      @message = JSON.parse(response.body)['message']
    rescue
      redirect_to root_url
    end
  end

  private
  def get_user(id='me')
    if is_logged_in?
      url = BASE_URL + "/api/v1/users/#{id}"
      headers = {'Authorization': "Bearer #{session[:token]['access_token']}"}
      response = RestClient.get(url, headers)
      data = JSON.parse(response.body)['data']
      (session[:user] = data['user']) unless current_user
    end
  end
end
