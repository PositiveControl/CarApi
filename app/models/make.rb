class Make < ApplicationRecord
  has_many :models, :dependent => :destroy
  validates_presence_of :brand
end
