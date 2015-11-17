ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: ':memory:')

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.text :first_name
    t.text :last_name
  end
end

class User < ActiveRecord::Base
  acts_as_multilingual :first_name, :last_name
end
