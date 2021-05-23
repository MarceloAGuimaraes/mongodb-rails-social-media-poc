class Account
    include Mongoid::Document
    field :email, type: String

    has_many :posts, dependent: :destroy, class_name: 'Post', validate: false
    belongs_to :social_media, class_name: 'SocialMedia'
    belongs_to :person, class_name: 'Person'
end
  