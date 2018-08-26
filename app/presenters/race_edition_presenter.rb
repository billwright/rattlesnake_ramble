# frozen_string_literal: true

class RaceEditionPresenter < SimpleDelegator

  ADULT_CATEGORY_KEYS = %i[men_under_20 women_under_20 men_20s women_20s men_30s women_30s men_masters women_masters]
  KIDS_CATEGORY_KEYS = %i[boys girls]

  def initialize(race_edition)
    super(race_edition)
  end

  def category_size_map
    race_entries.each { |entry| assign_category(entry) }
    grouped_race_entries = race_entries.group_by(&:category_name)
    categories.map { |category| [category.name, grouped_race_entries[category.name]&.size || 0] }
  end

  private

  def categories
    category_keys.map { |name| Results::Categories.find(name) }
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
end
