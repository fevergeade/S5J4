json.extract! private_message, :id, :content, :created_at, :updated_at
json.url private_message_url(private_message, format: :json)
