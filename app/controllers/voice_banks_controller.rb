class VoiceBanksController < ApplicationController
  before_action :authenticate_user!

  def edit
    @voice_bank = VoiceBank.find(params[:id])
  end

  def create
    if params[:utauloid_id]
    if VoiceBank.create! voice_bank_params
      redirect_to 
  end

  def update
  end

  def destroy
  end

  private
  def voice_bank_params
    params.require(:voice_bank).permit(:name, :download_link, :is_append)
  end


end
