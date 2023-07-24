class Child < ApplicationRecord
  belongs_to :customer
  has_many :transfer
end
