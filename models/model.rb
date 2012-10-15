# -*- encoding: utf-8 -*-

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('my_database.db')
# DB = Sequel.postgres('my_database', :user => 'user', :password => 'password', :host => 'localhost')

class Log < Sequel::Model
  plugin :timestamps, :update_on_create => true
  
  set_schema do
    primary_key :id
    String :lucky
    foreign_key :user_id, :users
    timestamps :created_at
    timestamps :updated_at
  end
  many_to_one :users

  def self.fetch(limit, page)
    return self.order(Sequel.desc(:created_at)).limit(limit, limit * page)
  end
end

class User < Sequel::Model
  plugin :timestamps, :update_on_create => true

  set_schema do
    primary_key :id
    String :name
    timestamps :created_at
    timestamps :updated_at
  end
  one_to_many :logs
end

Log.create_table if not Log.table_exists?
User.create_table if not User.table_exists?

# Add Initial Data
if Log.all.count == 0 and User.all.count == 0
  DB.transaction do
    user = User.new(:name => 'John Doe').save
    Log.new(:lucky => '大吉', :user_id => user.id).save
  end
end
