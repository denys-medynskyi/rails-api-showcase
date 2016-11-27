class PostSerializer < ActiveModel::Serializer
  # cache key: 'post', expires_in: 1.hour
  attributes :id, :title, :body
  belongs_to :user
end
