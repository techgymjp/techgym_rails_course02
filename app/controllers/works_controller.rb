class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: "#{Work.model_name.human}の作成に成功しました。"
    else
      render :new
    end
  end

  def update
    if @work.update(work_params)
      redirect_to @work, notice: "#{Work.model_name.human}の更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    @work.destroy
    redirect_to works_path, notice: "#{Work.model_name.human}の削除に成功しました。"
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:site_type, :url, :title, :reward_min, :reward_max, :detail, :expired_at)
    end
end
