class Review < ApplicationRecord
  belongs_to :user
  belongs_to :train
end
