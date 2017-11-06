class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :update_schedule, :destroy]
  before_action :set_project, only: [:index, :show, :new, :create]
  MAX_TASK_ROW = 10

  # GET /tasks
  # GET /tasks.json
  def index
    redirect_to @project
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @all_status = TaskStatus.all
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
    @tasks = @project.tasks.build(Array.new(MAX_TASK_ROW, {}))
    divided_days = divide_schedule_date @project
    @tasks.map! {|t| t.schedules.build(divided_days) && t}
  end

  # GET /tasks/1/edit
  def edit
    @tasks = Task.all
  end

  # POST /tasks
  def create
    default_schedule_time = [{'08:00' => '21:00'}]
    @project = Project.where(:id => params[:project_id], :user_id => current_user.id).first
    tasks_params.each_value do |t|
      next if t[:subject].empty? or t[:schedules].nil?
      @task = @project.tasks.build({:subject => t[:subject]})
      @res = @task.save
      @schedule = t[:schedules].each_value do |s|
        @task.schedules.create(:date => s[:date], :time => default_schedule_time) if s[:enabled] == "1"
      end
    end

    respond_to do |format|
      format.html { redirect_to @project, notice: '作成しました' }
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      begin
        # アクティビティに更新情報を記録
        old_id = @task.status.id
        if !task_params[:status].eql?(old_id)
          Activity.create(
            :user_id => current_user.id,
            :behavior_id => Behavior.find_by({:name => 'CHANGE_STATUS'}).id,
            :target_id => @task.id,
            :update_from => old_id,
            :update_to => task_params[:status],
            :meta => []
          )
        end
        format.html { redirect_to @task, notice: 'ステータスを更新しました' }
      rescue => e
        format.html { redirect_to @task, notice: '更新に失敗しました' }
      end
    end
  end

  def update_schedule
    Schedule.transaction do
      # 更新
      schedule_params.each do |schedule_id, time_sets|
        tmp = []
        time_sets[:time].each_value do |time_set|
          if time_set[:start_at].present? && time_set[:end_at].present?
            time_set[:end_at], time_set[:start_at] = time_set[:start_at], time_set[:end_at] if time_set[:start_at] > time_set[:end_at]
            tmp.push({time_set[:start_at] => time_set[:end_at]})
          end
        end
        if(tmp.empty?)
          Schedule.find(schedule_id).destroy
        else
          Schedule.find(schedule_id).update(:time => tmp)
        end
      end

      # 新規登録
      new_schedule_params.each do |tmp_id, time_sets|
        tmp = []
        time_sets[:time].each_value do |time_set|
          if time_set[:start_at].present? && time_set[:end_at].present?
            time_set[:end_at], time_set[:start_at] = time_set[:start_at], time_set[:end_at] if time_set[:start_at] > time_set[:end_at]
            tmp.push({time_set[:start_at] => time_set[:end_at]})
          end
        end
        if(tmp.present? && time_sets[:date].present?)
          Schedule.create(
            :task_id => @task.id,
            :date => time_sets[:date],
            :time => tmp,
          )
        end

      end

      # アクティビティログに記録
      Activity.create(
        :user_id => current_user.id,
        :behavior_id => Behavior.find_by({:name => 'CHANGE_SCHEDULE'}).id,
        :target_id => @task.id,
        :meta => []
      )
    end
    redirect_to task_path(@task), notice: "更新しました"
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@task.project), notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.where(:id => params[:project_id], :user_id => current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tasks_params
      params.require(:tasks)
    end

    def task_params
      params.require(:task).permit(:status)
    end

    def schedule_params
      params.require(:schedules)
    end

    def new_schedule_params
      params.require(:new_schedules)
    end

    def divide_schedule_date(project)
      (project.start_on..project.end_on).map {|date| {date: date}}
    end
end
