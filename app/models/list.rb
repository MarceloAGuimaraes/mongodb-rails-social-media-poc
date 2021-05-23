class List
  include Mongoid::Document
  field :name, type: String
  embeds_many :persons
end
