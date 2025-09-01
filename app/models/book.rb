# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  # 動作確認のため一時的に追加
  validates :title,  presence: true
  validates :author, presence: true
  validates :memo,   presence: true
end
