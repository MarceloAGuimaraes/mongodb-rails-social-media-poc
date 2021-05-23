class Post
    include Mongoid::Document
    field :text, type: String
    field :post_date, type: Date
    field :link, type: String
    index text: 'text'

    belongs_to :account, optional: true
    belongs_to :social_media, class_name: 'SocialMedia', optional: true

    scope :by_date, ->(date_range){ where(post_date: date_range[:min]..date_range[:max]) }
    scope :by_text, ->(text) { where('$text' => {'$search' => text }) }
    scope :by_network, ->(networks) { where(social_media_id: networks )}
    
end
  