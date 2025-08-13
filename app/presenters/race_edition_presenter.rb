# frozen_string_literal: true

class RaceEditionPresenter < SimpleDelegator
  ADULT_CATEGORY_KEYS = %i[men_under_20 women_under_20 men_20s women_20s men_30s women_30s men_40s women_40s men_50s women_50s men_60_plus women_60_plus]
  KIDS_CATEGORY_KEYS = %i[boys girls]

  def initialize(race_edition, params = {})
    super(race_edition)
    @params = params
  end

  def category_size_map
    race_entries.each { |entry| assign_category(entry) }
    grouped_race_entries = race_entries.group_by(&:category_name)
    categories.map { |category| [category.name, grouped_race_entries[category.name]&.size || 0] }
  end

  def edition_count
    return nil unless year.present?

    year - 2004
  end

  def short_description
    case race&.name
      when "Rattlesnake Ramble Trail Race - Odd Years"
        "Fowler Trail First"
      when "Rattlesnake Ramble Trail Race - Even Years"
        "Eldorado Trail First"
      when "Rattlesnake Ramble Kids Race"
        "Kids Race"
      else
        nil
    end
  end

  def sorted_race_entries
    race_entries.joins(:racer).order(sort_param).map { |re| RaceEntryPresenter.new(re) }
  end

  def year
    date&.year
  end

  def description_path
    if date&.year.even?
      'even_year_course_description'
    else
      'odd_year_course_description'
    end
  end

  private

  attr_reader :params

  def categories
    category_keys.map { |key| Results::Categories.find(key) }
  end

  def category_keys
    name.downcase.include?('kids') ? KIDS_CATEGORY_KEYS : ADULT_CATEGORY_KEYS
  end

  def assign_category(race_entry)
    racer = race_entry.racer
    category = categories.find do |category|
      category.age_range.include?(racer.current_age) && category.genders.include?(racer.gender)
    end
    race_entry.category_name = category.name
  end

  def sort_param
    params[:sort] || 'race_entries.bib_number,racers.last_name'
  end
end
