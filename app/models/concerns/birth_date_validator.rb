# frozen_string_literal: true

class BirthDateValidator < ActiveModel::Validator
  def validate(record)
    if record.birth_date.present? && (record.birth_date < '1900-01-01'.to_date)
      record.errors.add(:birth_date, "can't be before 1900")
    end
    if record.birth_date.present? && (record.birth_date > Date.today)
      record.errors.add(:birth_date, "can't be in the future")
    end
  end
end
