class Site::AnswerController < SiteController
    def validate
      @answer = Answer.find(params[:answer_id])
      UserStatistic.set_statistic(@answer, current_user)
    end
  end