class FingerprintsController < ApplicationController
  before_action :set_fingerprint, only: [:show, :edit, :update, :destroy]

  # GET /fingerprints
  # GET /fingerprints.json
  def index
    # @fingerprints = Fingerprint.all
  end

  # GET /fingerprints/1
  # GET /fingerprints/1.json
  def show
  end

  # GET /fingerprints/new
  def new
    @fingerprint = Fingerprint.new
  end

  # GET /fingerprints/1/edit
  def edit
  end

  # POST /fingerprints
  # POST /fingerprints.json
  def create
    @fingerprint = Fingerprint.new(fingerprint_params)

    respond_to do |format|
      if @fingerprint.save
        format.html { redirect_to @fingerprint, notice: 'Fingerprint was successfully created.' }
        format.json { render :show, status: :created, location: @fingerprint }
      else
        format.html { render :new }
        format.json { render json: @fingerprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    uploaded_io = params[:picture]
    File.open(Rails.root.join('app', 'assets', 'images', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    render :action => 'index'
  end

  def convert
    filename = params[:name]
    fingerprint = Fingerprint.new(filename)
    fingerprint.find_edges()

    render :action => "index"
  end

  # PATCH/PUT /fingerprints/1
  # PATCH/PUT /fingerprints/1.json
  def update
    respond_to do |format|
      if @fingerprint.update(fingerprint_params)
        format.html { redirect_to @fingerprint, notice: 'Fingerprint was successfully updated.' }
        format.json { render :show, status: :ok, location: @fingerprint }
      else
        format.html { render :edit }
        format.json { render json: @fingerprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fingerprints/1
  # DELETE /fingerprints/1.json
  def destroy
    @fingerprint.destroy
    respond_to do |format|
      format.html { redirect_to fingerprints_url, notice: 'Fingerprint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fingerprint
      @fingerprint = Fingerprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fingerprint_params
      params[:fingerprint]
    end
end
