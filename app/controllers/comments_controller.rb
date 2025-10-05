class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_commentable

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: t("controllers.common.notice_create", name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html do
          flash[:alert] = @comment.errors.full_messages.to_sentence
          redirect_to @commentable, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: t("controllers.common.notice_update", name: Comment.model_name.human) }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    comment = @commentable.comments.find(params[:id])
    if comment.user == current_user
      comment.destroy
      respond_to do |format|
        if params[:report_id]
          format.html { redirect_to report_path(@commentable), notice: t("controllers.common.notice_destroy", name: Comment.model_name.human) }
          format.json { head :no_content }
        elsif params[:book_id]
          format.html { redirect_to book_path(@commentable), notice: t("controllers.common.notice_destroy", name: Comment.model_name.human) }
          format.json { head :no_content }
        end
      end
    else
      redirect_to report_path(@commentable), alert: "権限がありません。"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
