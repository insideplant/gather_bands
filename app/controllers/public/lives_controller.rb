class Public::LivesController < ApplicationController
  def create
    unless Live.find_by(id: params[:id])
      @live = Live.create(live_params)
      @user = current_user
      @live_organization = LiveOrganization.create(band_id: @user.id, live_id: @live.id, host: true)
      redirect_to bands_path
    else
      @user = current_user
      LiveOrganization.create(band_id: @user.band_id, live_id: @live.id)
    end
  end

  def new
    @user = current_user
    @live = Live.new
  end

  def index
  end

  def show
    @live = Live.find(params[:id])
    @live_organization = LiveOrganization.find_by(live_id: @live.id, host: true)
    @host_band = Band.find(@live_organization.band_id)

  end

  def update
  end

  def edit
  end

  private

  def live_params
    params.require(:live).permit(Live::REGISTRABLE_ATTRIBUTES,:live_name,:amount,:introduction)
  end


end
