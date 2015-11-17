module ActsAsMultilingual
  class Builder
    JSON_TYPES = [:json, :jsonb].freeze
    TEXT_TYPES = [:text, :string].freeze

    attr_reader :klass, :options, :columns

    def initialize(klass, *args)
      @klass = klass
      @options = args.extract_options!.merge(default_options)
      @columns = args.map(&:to_s)

      check_columns!
      prepare_klass
      define_accessors
    end

    private

    def default_options
      { locales: I18n.available_locales, default_locale: I18n.locale }
    end

    def check_columns!
      columns.each do |column|
        check_column_presence!(column)
        check_column_type!(column)
      end
    end

    def check_column_presence!(column)
      return if klass.columns_hash.keys.include?(column)
      fail Exceptions::MissingColumn,
           "Column `#{column}` is missing in table `#{klass.table_name}`"
    end

    def check_column_type!(column)
      if (JSON_TYPES + TEXT_TYPES).include?(klass.columns_hash[column].type)
        return
      end

      fail Exceptions::InvalidColumnType,
           "Column `#{column}` has invalid column type"
    end

    def prepare_klass
      columns.each do |column|
        if TEXT_TYPES.include?(klass.columns_hash[column].type)
          klass.send(:serialize, column, Hash)
        end
      end
    end

    def define_accessors
      columns.each do |column|
        options[:locales].each do |locale|
          define_reader(column, locale)
          define_writer(column, locale)
        end

        alias_default_locale(column)
      end
    end

    def define_reader(column, locale)
      klass.send(:define_method, "#{column}_#{locale}") do
        (@_acts_as_multilingual_cache ||= {}).fetch(column) do
          @_acts_as_multilingual_cache[column] =
            AttributeProxy.new(self, column)
        end.read(locale)
      end
    end

    def define_writer(column, locale)
      klass.send(:define_method, "#{column}_#{locale}=") do |value|
        (@_acts_as_multilingual_cache ||= {}).fetch(column) do
          @_acts_as_multilingual_cache[column] =
            AttributeProxy.new(self, column)
        end.write(locale, value)
      end
    end

    def alias_default_locale(column)
      klass.send(:alias_method, column, "#{column}_#{options[:default_locale]}")
      klass.send(:alias_method,
                 "#{column}=",
                 "#{column}_#{options[:default_locale]}=")
    end
  end
end
