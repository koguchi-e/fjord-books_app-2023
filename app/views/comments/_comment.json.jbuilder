json.extract! comment, :id, :body, :user_id, :book_id, :report_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
