# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    create_mentioning_list
    create_mentioned_list
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
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

  def create_mentioning_list
    this_report = Report.find(params[:id])
    mentioning_reports = []

    Report.where.not(id: this_report.id).find_each do |other_report|
      mentioning_reports << other_report if this_report.content.match?(%r{http://127\.0\.0\.1:3000/reports/#{other_report.id}(?!\d)})
      @mentioning_reports = mentioning_reports
    end
  end

  def create_mentioned_list
    this_report = Report.find(params[:id])
    mentioned_reports = []
    Report.where.not(id: this_report.id).find_each do |report|
      mentioned_reports << report if report.content.match?(%r{http://127\.0\.0\.1:3000/reports/#{this_report.id}(?!\d)})
    end
    @mentioned_reports = mentioned_reports
  end
end
