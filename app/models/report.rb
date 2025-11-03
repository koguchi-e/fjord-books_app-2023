# frozen_string_literal: true

class Report < ApplicationRecord
  after_save :recreate_mention_list

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many  :mention_from_me,
            class_name: 'ReportMention',
            foreign_key: :source_report_id,
            dependent: :destroy,
            inverse_of: :source_report

  has_many  :mentioning_reports,
            through: :mention_from_me,
            source: :target_report

  has_many  :mention_to_me,
            class_name: 'ReportMention',
            foreign_key: :target_report_id,
            dependent: :destroy,
            inverse_of: :target_report

  has_many  :mentioned_reports,
            through: :mention_to_me,
            source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def recreate_mention_list
    mention_from_me.delete_all
    mentioned_ids = content.scan(%r{http://127.0.0.1:3000/reports/(\d+)}).flatten.map(&:to_i)

    mentioned_ids.uniq.each do |target_id|
      mentioning_report = Report.where.not(id:).find_by(id: target_id)
      mentioning_reports << mentioning_report if mentioning_report
    end
  end
end
