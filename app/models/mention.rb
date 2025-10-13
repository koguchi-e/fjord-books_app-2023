class Mention < ApplicationRecord
  belongs_to :mentinable, polymophic: true
  belongs_to :mentionabled_user, class_name: 'User'
end
