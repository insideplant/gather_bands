class Public::HomesController < ApplicationController
  def top
    @lives = Live.where(status: 2)
  end

  def about
  end
end
