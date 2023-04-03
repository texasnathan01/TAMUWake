class NotInPastValidator < ActiveModel::EachValidator
     def validate_each(record, attribute, value)
          if value.present? && value < DateTime.current
               record.errors.add(attribute, 'cannot be in the past')
          end
     end
end
