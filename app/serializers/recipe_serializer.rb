class RecipeSerializer
  include JSONAPI::Serializer
  attributes :url, :title, :country, :image
end