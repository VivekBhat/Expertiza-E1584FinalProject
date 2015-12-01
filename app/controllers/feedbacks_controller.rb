class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  def show
    @attachment = FeedbackAttachment.find_by_feedback_id(@feedback.id)
  end

  def download_feedback_attachment
    @attachment = FeedbackAttachment.find_by_feedback_id(params[:id])
    send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type,  :disposition => 'attachment; filename=' + @attachment.filename
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)

    if verify_recaptcha
      if @feedback.save
        if params[:feedback][:attachment]
          @attachment = FeedbackAttachment.new
          @attachment.uploaded_file = params[:feedback][:attachment]
          @attachment.feedback_id = @feedback.id
          if @attachment.save
            redirect_to @feedback, notice: 'Feedback was successfully created.'
          else
            redirect_to :back, notice: 'There was a problem while submitting your attachment.'
          end
        else
          redirect_to @feedback, notice: 'Feedback was successfully created.'
        end
      else
        render :new
      end
    else
      redirect_to :back, notice: 'Feedback not created.'
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      redirect_to @feedback, notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  def action_allowed?
    return true
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def feedback_params
    params.require(:feedback).permit(:user_id, :title, :description, :status)
  end
end