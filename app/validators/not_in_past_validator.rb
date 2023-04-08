class NotInPastValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors.add(attribute, "cannot be in the past") if value.present? && value < DateTime.current
    end
end