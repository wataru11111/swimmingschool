class Child < ApplicationRecord
  has_many :customer
  belongs_to :transfer
end
