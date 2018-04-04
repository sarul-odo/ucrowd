class StaticPagesController < ApplicationController
  def home
  end
  def help
  end
  def about
  end
  def contact
  end
  def status
    @competitions = Competition.all
    @users = User.all
    @submissions = Submission.all
  end
end
