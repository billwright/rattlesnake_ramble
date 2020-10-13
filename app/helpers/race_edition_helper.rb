class RaceEditionHelper
  def current_full_course_edition
    RaceEdition.full_course.order(date: :desc).first
  end

  def current_kids_course_edition
    RaceEdition.kids_race.order(date: :desc).first
  end
end
