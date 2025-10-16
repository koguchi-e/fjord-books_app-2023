# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :target_report, class_name: 'Report', inverse_of: :mention_from_me
  belongs_to :source_report, class_name: 'Report', inverse_of: :mention_to_me
end
