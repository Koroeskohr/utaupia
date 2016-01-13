class VoiceLanguagesController < ApplicationController
  def index
    # TODO : will_paginate
    @voice_languages = VoiceLanguage.all
  end

  def show
    @voice_language = VoiceLanguage.friendly.find(params[:id])
  end
end
