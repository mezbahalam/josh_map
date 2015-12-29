class CliniciansController < ApplicationController
  before_action :set_clinician, only: [:show, :edit, :update, :destroy]


  def index
    if params[:search].present?
      @clinicians = Clinician.near(params[:search], 5) 

    else
      @clinicians = Clinician.all
    end

    @hash = Gmaps4rails.build_markers(@clinicians) do |clinician, marker|
      marker.lat clinician.latitude
      marker.lng clinician.longitude
    end


  end

  def show
  end

  def new
    @clinician = Clinician.new
  end

  def edit
  end


  def create
    @clinician = Clinician.new(clinician_params)

    respond_to do |format|
      if @clinician.save
        format.html { redirect_to @clinician, notice: 'Clinician was successfully created.' }
        format.json { render :show, status: :created, location: @clinician }
      else
        format.html { render :new }
        format.json { render json: @clinician.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @clinician.update(clinician_params)
        format.html { redirect_to @clinician, notice: 'Clinician was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinician }
      else
        format.html { render :edit }
        format.json { render json: @clinician.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @clinician.destroy
    respond_to do |format|
      format.html { redirect_to clinicians_url, notice: 'Clinician was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_clinician
      @clinician = Clinician.find(params[:id])
    end

    def clinician_params
      params.require(:clinician).permit(:address, :latitude, :longitude)
    end
end
