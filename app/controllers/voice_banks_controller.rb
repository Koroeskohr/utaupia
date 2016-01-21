class VoiceBanksController < ApplicationController
  before_action :authenticate_user!

  def new
    @utauloid = Utauloid.friendly.find(params[:utauloid_id])
    @voice_bank = @utauloid.voice_banks.new
    redirect_to :root_path if @utauloid.creator != current_user
  end

  def edit
    @voice_bank = VoiceBank.find(params[:id])
  end

  def create
    utauloid = Utauloid.find(params[:voice_bank][:utauloid_id])
    redirect_to :root_path unless utauloid.creator == current_user
    @voice_bank = VoiceBank.new(voice_bank_params)
    @voice_bank.utauloid = utauloid

    if @voice_bank.save!
      redirect_to @voice_bank.utauloid
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
  def voice_bank_params
    params.require(:voice_bank).permit(:name, :download_link, :is_append, :utauloid_id)
  end


end
