class FavoriteSerializer
  include JSONAPI::Serializer
  attributes :recipe_link, :recipe_title, :country, :created_at
end