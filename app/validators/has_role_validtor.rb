class HasRoleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        user = User.find(record.user_id)
        if value.present? && value < DateTime.current
            record.errors.add attribute, "cannot be in the past"
        end
    end
end