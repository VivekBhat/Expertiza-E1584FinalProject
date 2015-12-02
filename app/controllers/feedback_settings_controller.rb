class FeedbackSettingsController < ApplicationController
  before_action :set_feedback_setting, only: [:show, :edit, :update, :destroy]

  # GET /feedback_settings
  def index
    @feedback_settings = FeedbackSetting.all
  end
def action_allowed?
  true
end
  # GET /feedback_settings/1
  def show
  end

  # GET /feedback_settings/new
  def new
    @feedback_setting = FeedbackSetting.new
  end

  # GET /feedback_settings/1/edit
  def edit
  end

  # POST /feedback_settings
  def create
    @feedback_setting = FeedbackSetting.new(feedback_setting_params)

    if @feedback_setting.save
      redirect_to @feedback_setting, notice: 'Feedback setting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /feedback_settings/1
  def update
    if @feedback_setting.update(feedback_setting_params)
      redirect_to @feedback_setting, notice: 'Feedback setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /feedback_settings/1
  def destroy
    @feedback_setting.destroy
    redirect_to feedback_settings_url, notice: 'Feedback setting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback_setting
      @feedback_setting = FeedbackSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_setting_params
      params.require(:feedback_setting).permit(:support_mail, :max_attachments, :max_attachment_size, :wrong_retries, :wait_duration, :wait_duration_increment, :support_team)
    end
end
