# frozen_string_literal: true

module Results
  class Categories
    def self.find(category_name)
      all[category_name]
    end

    def self.all
      {
          combined_overall: Results::Category.new('Overall', %w[male female]),
          men_overall: Results::Category.new('Overall Men', %w[male]),
          women_overall: Results::Category.new('Overall Women', %w[female]),
          men_under_20: Results::Category.new('Under 20 Men', %w[male], nil, 19),
          women_under_20: Results::Category.new('Under 20 Women', %w[female], nil, 19),
          men_20s: Results::Category.new('20 to 29 Men', %w[male], 20, 29),
          women_20s: Results::Category.new('20 to 29 Women', %w[female], 20, 29),
          men_30s: Results::Category.new('30 to 39 Men', %w[male], 30, 39),
          women_30s: Results::Category.new('30 to 39 Women', %w[female], 30, 39),
          men_masters: Results::Category.new('Masters Men (40+)', %w[male], 40),
          women_masters: Results::Category.new('Masters Women (40+)', %w[female], 40),
          boys: Results::Category.new('Boys', %w[male]),
          girls: Results::Category.new('Girls', %w[female])
      }.with_indifferent_access
    end
  end
end
