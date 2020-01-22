json.extract! post, :id, :user, :content, :picture, :created_at, :updated_at
json.url post_url(post, format: :json)
