class Admin::LivesController < ApplicationController
  def index
    @lives = Live.where(registered_person: true)
  end

  def update
    @live = Live.find(params[:id])
    if @live.update(status: "waiting_live")
      redirect_to admin_lives_path
    else
      @lives = Live.all
      render :index
    end
  end

  private

  def live_params
    params.require(:live).permit(:status)
  end
end
