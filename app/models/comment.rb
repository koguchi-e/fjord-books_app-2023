class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :book
  belongs_to :report
end
