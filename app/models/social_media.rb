class SocialMedia
    include Mongoid::Document    
    has_many :accounts, dependent: :destroy
    has_many :posts, class_name: 'Post', dependent: :destroy, validate: false

    field :name, type: String
end
  