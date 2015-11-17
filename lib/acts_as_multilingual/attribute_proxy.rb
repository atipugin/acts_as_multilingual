module ActsAsMultilingual
  class AttributeProxy
    attr_reader :owner, :column

    def initialize(owner, column)
      @owner = owner
      @column = column
    end

    def read(locale)
      owner[column][locale]
    end

    def write(locale, value)
      owner[column][locale] = value
      owner[column].delete(locale) unless value
    end
  end
end
