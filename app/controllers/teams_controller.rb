class TeamsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_team, only: %i[show edit update destroy]
  before_action :set_team, only: %i[show edit update destroy owner_change]

  def index
    @teams = Team.all
  end

  def show
    @working_team = @team
    change_keep_team(current_user, @team)
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.new(team_params)
    if @team.owner_id  == current_user

    end
  end



  def create
    @team = Team.new(team_params)
    @team.owner = current_user
    if @team.save
      @team.invite_member(@team.owner)
      redirect_to @team, notice: I18n.t('views.messages.create_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: I18n.t('views.messages.update_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :edit
    end
  end

  def destroy
    # @team = Team.new(team_params)
    # if @team.owner == current_user
    @team.destroy
    redirect_to teams_url, notice: I18n.t('views.messages.delete_team')
  end


  def owner_change
    if @team.update(owner_params)
      OwnerMailer.mail_new_owner(@new_owner).deliver
      redirect_to @team
    else
      render @team
    end
  end

#
# def pass_owner
#   @assign = Assign.find(params[:assign])
#   if @team.update(owner_id: @assign.user.id)
#     # Move leader privileges and send mail to newly authorized users
#     PassOwnerMailer.pass_owner_mail(@assign, @team).deliver redirect_to team_url,
#     notice: I18n.t('views.messages.assign_to_leader', team: @team.name)
#   else
#     # What to do when leader privileges cannot be transferred
#     redirect_to team_url, notice: I18n.t('views.messages.cannot_assign_to_leader')
#   end
# end




  # def owner
  #   @team = Team.friendly.find(params[:team_id])
  #   new_owner = Assign.find(params[:id])
  #   @team.owner = new_owner.user
  #   @team.update(team_params)
  #   ownerMailer.owner_owner_mail(new_owner.user.email, @team.name).deliver
  #   redirect_to team_url
  #   #redirect_to team_url(params[:team_id])
  # end

  def dashboard
    @team = current_user.keep_team_id ? Team.find(current_user.keep_team_id) : current_user.teams.first
  end

  private

  def set_team
    @team = Team.friendly.find(params[:id])
  end

  def owner_params
    params.permit(:owner_id)
  end

  def team_params
    params.fetch(:team, {}).permit %i[name icon icon_cache owner_id keep_team_id]
  end


end
