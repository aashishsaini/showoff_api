if Rails.env == 'production'
  BASE_URL = Rails.application.credentials[:base_url]
  CLIENT_ID = Rails.application.credentials[:client_id]
  CLIENT_SECRET = Rails.application.credentials[:client_secret]
else
  BASE_URL = ENV.fetch('BASE_URL')
  CLIENT_ID = ENV.fetch('CLIENT_ID')
  CLIENT_SECRET = ENV.fetch('CLIENT_SECRET')
end
