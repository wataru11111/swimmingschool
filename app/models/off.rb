class Off < ApplicationRecord
  belongs_to :child
  has_many :transfers
end
