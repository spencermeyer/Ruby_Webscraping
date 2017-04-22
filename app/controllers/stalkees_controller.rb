class StalkeesController < ApplicationController
  before_action :set_stalkee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?

  # GET /stalkees
  # GET /stalkees.json
  def index
    @stalkees = Stalkee.all
  end

  # GET /stalkees/1
  # GET /stalkees/1.json
  def show
  end

  # GET /stalkees/new
  def new
    @stalkee = Stalkee.new
  end

  # GET /stalkees/1/edit
  def edit
  end

  # POST /stalkees
  # POST /stalkees.json
  def create
    @stalkee = Stalkee.new(stalkee_params)

    respond_to do |format|
      if @stalkee.save
        format.html { redirect_to @stalkee, notice: 'Stalkee was successfully created.' }
        format.json { render :show, status: :created, location: @stalkee }
      else
        format.html { render :new }
        format.json { render json: @stalkee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stalkees/1
  # PATCH/PUT /stalkees/1.json
  def update
    respond_to do |format|
      if @stalkee.update(stalkee_params)
        format.html { redirect_to @stalkee, notice: 'Stalkee was successfully updated.' }
        format.json { render :show, status: :ok, location: @stalkee }
      else
        format.html { render :edit }
        format.json { render json: @stalkee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stalkees/1
  # DELETE /stalkees/1.json
  def destroy
    @stalkee.destroy
    respond_to do |format|
      format.html { redirect_to stalkees_url, notice: 'Stalkee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stalkee
      @stalkee = Stalkee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stalkee_params
      params.require(:stalkee).permit(:parkrunner)
    end
end
