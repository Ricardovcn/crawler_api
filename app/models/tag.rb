class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String

  has_many :quotes

end

