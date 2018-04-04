class SubmissionsController < ApplicationController

  def index
  end

  def new
    @submission = Submission.new
  end

  def create
  end
  def check
    if params[:submit_code]
      @@success = run_code
      submit_code
    else
      @@success = run_code
      respond_to do |format|
        format.html { redirect_to competition_path(params[:submission][:competition_id]), notice: @@success }
      end
    end
  end

  private
    def submission_params
      params.require(:submission).permit(:competition_id, :comment)
    end

  def submit_code
    @submission = Submission.new(submission_params)
    @submission.user_id = session[:user_id]
    if @@success == 'Success'
      @submission.point = 1000
    else
      @submission.point = 500
    end
    respond_to do |format|
      if @submission.save
        notice = 'Submission was successfully created.'
      else
        notice = 'Submission was unsuccessfully created.'
      end
      format.html { redirect_to competition_path(@submission.competition_id), notice: notice }
    end
  end

  def run_code
    # compile and file
    cmp_prm = params[:submission][:competition_id].to_s
    usr_prm = session["user_id"].to_s
    competition = Competition.find_by_id(cmp_prm)
    current_date = Time.now.strftime("%d%m%Y%H%M_%S")
    language = 'python'
    language_extension = '.py'
    language_default_extension = '.rb'
    file = 'io/'

    input = "input_" + cmp_prm + "_" + usr_prm + "_" + current_date.to_s + language_default_extension
    input_content = competition.input
    output = "output_" + cmp_prm + "_" + usr_prm + "_" + current_date.to_s + language_default_extension
    output_db = "output_db_" + cmp_prm + "_" + usr_prm + "_" + current_date.to_s + language_default_extension
    output_content = competition.output

    execute = "execute_" + cmp_prm + "_" + usr_prm + "_" + current_date.to_s + language_default_extension
    source = "source_" + cmp_prm + "_" + usr_prm + "_" + current_date.to_s + language_extension

    content = params[:submission][:comment].to_s

    sys = language + ' ' + file + source + ' < ' + file + input + ' > ' + file + output

    if File.exists?("io")
      system 'rm', '-r', 'io'
    end
    system 'mkdir', '-p', 'io'

    File.open(file+input, "w+") do |f|
      f.write(input_content)
    end

    File.open(file+output_db, "w+") do |f|
      f.write(output_content)
    end

    File.open(file+source, "w+") do |f|
      f.write(content)
    end

    File.open(file+execute, "w+") do |f|
      f.write(system(sys))
    end

    @output = File.open(file+output)
    @output_db = File.open(file+output_db)

    @@success = 'Unsucess'
    @output.each do |e|
      if(!@output_db.equal?(e))
        @@success = 'Success'
        puts '_____________'
        puts e
      end
    end

    success = FileUtils.compare_file(file+output_db, file+output)

    puts @output
    puts @output_db
    puts FileUtils.compare_file(file+output_db, file+output)
    puts success
    print FileUtils.compare_file(file+output_db, file+output)
    puts output_db, output
    puts '______________ '

    # system 'rm', '-r', 'io'
    return @@success
  end
end
