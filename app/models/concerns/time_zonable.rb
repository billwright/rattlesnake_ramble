# frozen_string_literal: true

# Used for models with one or more datetime attributes
# that need to be localized to `home_time_zone`.
# Also sets a default date when an object of the including
# class responds to `date`.
#
module TimeZonable
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def zonable_attributes(*attributes)
      attributes.each(&method(:zonable_attribute))
    end

    def zonable_attribute(attribute)
      define_method :"#{attribute}_local" do
        unless time_zone_valid?(home_time_zone)
          return nil
        end
        send(attribute)&.in_time_zone(home_time_zone)
      end

      define_method :"#{attribute}_local=" do |datetime_or_time|
        if datetime_or_time.present?
          unless time_zone_valid?(home_time_zone)
            raise ArgumentError, "#{attribute}_local cannot be set without a valid home_time_zone"
          end
          local_string = if datetime_or_time =~ ::RambleConfig.military_time_regex and respond_to?(:date)
                           "#{date.to_s} #{datetime_or_time}"
                         else
                           datetime_or_time.to_s
                         end
          self.send("#{attribute}=", local_string.in_time_zone(home_time_zone))
        else
          self.send("#{attribute}=", nil)
        end
      end
    end
  end

  def time_zone_valid?(time_zone_string)
    time_zone_string.present? && ActiveSupport::TimeZone[time_zone_string].present?
  end
end
