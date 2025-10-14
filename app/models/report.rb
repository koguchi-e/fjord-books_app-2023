# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  # 自分が言及する側
  has_many :mention_from_me, class_name: "ReportMention", foreign_key: :source_report_id
  has_many :mentioned_reports, through: :mention_from_me, source: :target_report

  # 自分が言及される側
  has_many :mention_to_me, class_name: "ReportMention", foreign_key: :target_report_id
  has_many :mentioning_reports, through: :mention_to_me, source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
