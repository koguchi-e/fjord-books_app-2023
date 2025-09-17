# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validate :avatar_content_type

  def avatar_content_type
    return unless avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])

    errors.add(:avatar, 'ファイル形式は、jpg/png/gifのいずれかにしてください。')
  end
end
