module RaceEditionHelper
  def current_full_course_edition
    @current_full_course_edition ||= begin
      race_edition = RaceEdition.full_course.where("date >= ?", Date.today).order(date: :asc).first
      race_edition ||= RaceEdition.full_course.order(date: :desc).first
      RaceEditionPresenter.new(race_edition)
    end
  end

  def current_kids_course_edition
    @current_kids_course_edition ||= begin
      race_edition = RaceEdition.kids_race.where("date >= ?", Date.today).order(date: :asc).first
      race_edition ||= RaceEdition.kids_race.order(date: :desc).first
      RaceEditionPresenter.new(race_edition)
    end
  end

  def race_editions_not_aligned?
    current_full_course_edition.date != current_kids_course_edition.date
  end
end
