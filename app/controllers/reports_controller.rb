# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    @mentioned_reports = @report.mentioned_reports
    @mentioning_reports = @report.mentioning_reports

    @mentioned_reports.each do |r|
      puts "★言及された: #{r.id}, #{r.title}"
    end

    @mentioning_reports.each do |r|
      puts "★言及してる: #{r.id}, #{r.title}"
    end

  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      create_mention_list(@report)
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def create_mention_list(report)
    report.mention_from_me.destroy_all
    mentioned_ids = report.content.scan(%r{reports/(\d+)}).flatten.map(&:to_i)
    mentioned_ids.uniq.each do |target_id|
      next if target_id == report.id
      ReportMention.create!(source_report_id: report.id, target_report_id: target_id)
      ReportMention.create!(
        source_report_id: report.id,  # 自分が言及する側
        target_report_id: target_id   # 本文で書いた相手
      )
    end
  end
end
