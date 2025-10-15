# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_commentable
  before_action :authorize_current_user, only: %i[edit update destroy]

  def index
    @comments = Comment.all
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    render :edit
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to redirect_to_path, notice: notice_message(:create)
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to redirect_to_path, status: :unprocessable_entity
    end
  end

  def update
    comment = @commentable.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to redirect_to_path, notice: notice_message(:update)
    else
      redirect_to redirect_to_path, status: :unprocessable_entity
    end
  end

  def destroy
    comment = @commentable.comments.find(params[:id])
    if @comment.destroy
      redirect_to redirect_to_path, notice: notice_message(:destroy)
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    if params[:report_id]
      @commentable = Report.find(params[:report_id])
    elsif params[:book_id]
      @commentable = Book.find(params[:book_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_current_user
    unless @comment.user == current_user
      redirect_to redirect_to_path, alert: '権限がありません。'
    end
  end

  def redirect_to_path
    if params[:report_id]
      report_path(@commentable)
    else
      book_path(@commentable)
    end
  end

  def notice_message(action)
    t("controllers.common.notice_#{action}", name: Comment.model_name.human)
  end
end
