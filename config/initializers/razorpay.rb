require "razorpay"
key_id = Rails.application.credentials.dig(:razorpay, :key_id)
secret_key = Rails.application.credentials.dig(:razorpay, :key_secret)
Razorpay.setup(key_id, secret_key)