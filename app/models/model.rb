class Model < ApplicationRecord
  belongs_to :make
  validates_presence_of :model_title
end
