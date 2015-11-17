module ActsAsMultilingual
  module Extension
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_multilingual(*args)
        ActsAsMultilingual::Builder.new(self, *args)
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsMultilingual::Extension)
