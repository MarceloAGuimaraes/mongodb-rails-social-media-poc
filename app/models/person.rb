class Person
    include Mongoid::Document
    field :name, type: String

    has_many :accounts, dependent: :destroy
end
  