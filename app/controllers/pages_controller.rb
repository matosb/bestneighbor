class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :aide, :home, :cgu, :robots ]
  def home

  end
  def aide

  end
  def choix

  end
  def cgu

  end
  def creerliste

  end
  def prendreliste

  end
  def creertrajet

  end
  def prendretrajet

  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

end
