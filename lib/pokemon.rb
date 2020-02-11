require 'pry'
class Pokemon

    attr_reader :id, :db
    attr_accessor :name, :type

    def initialize(poke_hash)
        #binding.pry
        @id = poke_hash[:id] 
        @name = poke_hash[:name]
        @type = poke_hash[:type] 
        @db = poke_hash[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
       # binding.pry
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL
        
        x = db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first
    end

    def self.new_from_db(row, db)
        pokemon = {}
        pokemon[:name] = row[1]
        pokemon[:type] = row[2]
        pokemon[:id] = row[0]
        pokemon[:db] = db
        new_pokemon = Pokemon.new(pokemon)
        new_pokemon
    end
end
