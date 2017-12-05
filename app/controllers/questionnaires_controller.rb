class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaires, only: [:index, :show, :edit, :update, :destroy]

  # GET /questionnaires
  # GET /questionnaires.json
  def index
  end

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
  end

  # GET /questionnaires/new
  def new
    @questionnaire = questionnaire.new
    @questionnaire.user_id = current_user.id
  end

  # GET /questionnaires/1/edit
  def edit
  end

  def update
    respond_to do |format|
      # 回答内容を削除
      current_user.user_questionnaires.destroy_all
      # 回答を保存
      questionnaire_params.each do |q_id, answer|
        answer = current_user.user_questionnaires.build(
          questionnaire_id: q_id,
          answer: answer,
        )
        answer.save!
      end
      format.html { redirect_to questionnaires_path, notice: 'アンケートに回答しました' }
    end
  end

  # DELETE /questionnaires/1
  # DELETE /questionnaires/1.json
  def destroy
    @questionnaire.destroy
    respond_to do |format|
      format.html { redirect_to questionnaires_url, notice: 'プロジェクトを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionnaires
      @questionnaires = Questionnaire.all
      @user_questionnaires = current_user.user_questionnaires
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questionnaire_params
      params.require(:answer)
    end
end
