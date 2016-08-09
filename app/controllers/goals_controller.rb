class GoalsController < ApplicationController

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.status = "uncompleted"
    if @goal.save

      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def index
    @public_goals = Goal.where(private: "public")
    @private_goals = current_user.goals.where(private: "private")

    render :index

  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    current_user.points += 62
    current_user.save

    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :private)
  end
end
