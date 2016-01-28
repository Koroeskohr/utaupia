class VoiceCharacteristicsController < ApplicationController
  def index
    # TODO : will_paginate
    @voice_characteristics = VoiceCharacteristic.all
  end

  def show
    @voice_characteristic = VoiceCharacteristic.friendly.find(params[:id])
  end
end
