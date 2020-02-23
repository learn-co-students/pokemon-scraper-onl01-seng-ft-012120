
require 'pry'

class Pokemon
attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id 
        @name = name
        @type = type 
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon(name, type)
        VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(num, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL
        p = db.execute(sql, num)
        id = p[0][0]
        name = p[0][1]
        type = p[0][2]
        new_pokemon = Pokemon.new(id: id, name: name, type: type, db: db) 
        new_pokemon
    end
end
