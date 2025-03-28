Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # Đúng frontend

    resource '*',
      headers: :any,
      credentials: true, # <-- bắt buộc để frontend có thể nhận và gửi cookie
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
  end