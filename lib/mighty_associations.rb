module MightyAssociations
end

class ActiveRecord::Base
  
  class << self
    def has_many_with_class_methods(*args, &block)
      has_many_without_class_methods(*args, &block)

      reflection = reflect_on_association(args.first)
      if reflection.options[:through]
        through_association = reflection.through_reflection.options[:as] ? reflection.through_reflection.name : reflection.through_reflection.name.to_s.singularize
        class_eval <<-RUBY, __FILE__, __LINE__
          def self.#{reflection.name}
            ::#{reflection.class_name}.includes(:#{through_association})
              .where(:"#{reflection.through_reflection.table_name}.#{reflection.through_reflection.foreign_key}" => select(:id))
          end
        RUBY
      else
        class_eval <<-RUBY, __FILE__, __LINE__
          def self.#{reflection.name}
            ::#{reflection.class_name}.where(:#{reflection.foreign_key} => select(:id))
          end
        RUBY
      end
    end
    alias_method_chain :has_many, :class_methods
    
    def belongs_to_with_class_methods(*args, &block)
      belongs_to_without_class_methods(*args, &block)
      reflection = reflect_on_association(args.first)
      class_eval <<-RUBY, __FILE__, __LINE__
        def self.#{reflection.name.to_s.pluralize}
          ::#{reflection.class_name}.where(:#{reflection.active_record.primary_key} => select(:#{reflection.foreign_key}))
        end
      RUBY
    end
    alias_method_chain :belongs_to, :class_methods
  end
end
