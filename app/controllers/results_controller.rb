class ResultsController < ApplicationController
  # before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    record_vistor_information
    Rails.logger.info "AWOOGA Here the results controller index action"
    if params[:order] == 'pos'
      @results = Result.eastleigh.all.order(run_id: :asc, pos: :asc)
    elsif params[:order] == 'age'
      @results = Result.eastleigh.all.order(run_id: :asc, age_grade_position: :asc)
    elsif params[:order] == 'a12'
      @results = Result.eastleigh.top12s.all.order(run_id: :asc, age_grade_position: :asc)
    else
      @results = Result.eastleigh.all.order(run_id: :asc, pos: :asc)
    end
    @runs = Run.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:pos, :parkrunner, :time, :age_cat, :age_grade, :gender, :gender_pos, :club, :note, :total)
    end

    # record vistor information
    def record_vistor_information
      if request.ip && request.user_agent
        visit=Visit.new(ip_address: request.ip, browser: request.user_agent)
        visit.save
      end
    end
end
