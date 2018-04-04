class CompetitionsController < ApplicationController
  include Paperclip::Glue
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  # GET /Competitions
  # GET /Competitions.json
  def index
    @competitions = Competition.all
    if params[:search]
      @competitions = Competition.paginate(page: params[:page]).search(params[:search])
    elsif params[:sort]
      @competitions = Competition.paginate(page: params[:page]).order(params[:sort] + ' ' + params[:direction])
    else
      @competitions = Competition.paginate(page: params[:page])
    end

    # if @competitions
    #   current_date = Time.now()
    #   @competitions.each do |competition|
    #     year = current_date.year - competition.end_date.to_time.year
    #     month = current_date.month - competition.end_date.to_time.month
    #     day = current_date.day - competition.end_date.to_time.day
    #     puts '_____________'
    #     puts year, month, day
    #   end
    # end
    # @competitions = Competition.search(params[:search])
  end

  # GET /Competitions/1
  # GET /Competitions/1.json
  def show
    # @competition = Competition.find(params[:id])
    # render 'submissions/new'
  end
  def show_image
    @competition = Competition.find(params[:id])
    send_data @competition.image, :type => 'image/png',:disposition => 'inline'
  end

  # GET /Competitions/new
  def new
    @competition = Competition.new
  end

  # GET /Competitions/1/edit
  def edit
  end

  # POST /Competitions
  # POST /Competitions.json
  def create
    @competition = Competition.new(competition_params)
    respond_to do |format|
      if @competition.save
        format.html { redirect_to @competition, notice: 'Competition was successfully created.' }
        format.json { render :show, status: :created, location: @competition }
      else
        format.html { render :new }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Competitions/1
  # PATCH/PUT /Competitions/1.json
  def update
    respond_to do |format|
      if @competition.update(competition_params)
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Competitions/1
  # DELETE /Competitions/1.json
  def destroy
    @competition.destroy
    respond_to do |format|
      format.html { redirect_to competitions_url, notice: 'Competition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def sort_column
      Competition.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_competition
      @competition = Competition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params.require(:competition).permit(:title, :content, :user_id, :explanation, :input, :output, :start_date, :end_date, :image)
    end
end
