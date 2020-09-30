module RaceReportsHelper
  def available_race_reports
    race_reports_directory = Rails.root.join("app", "views", "pages", "race_reports")
    years = race_reports_directory.each_child.map { |path| path.basename.to_s.split(".").first }
    years.sort.reverse
  end
end
