class VoicebankTypesController < ApplicationController
  def index
    # TODO : will_paginate
    @voicebank_types = VoicebankType.all
  end

  def show
    @voicebank_type = VoicebankType.friendly.find(params[:id])
  end
end
