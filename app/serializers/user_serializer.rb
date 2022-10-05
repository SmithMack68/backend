class UserSerializer < ActiveModel::Serializer
  attributes :username, :id
  has_many :casts
  has_many :spells
end
