class Pokemon
    
    attr_accessor :name, :type, :id, :db
    def initialize(attributes)
        attributes.each do |key, value| 
            self.send(("#{key}="), value)   
        end
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon(name, type)
            VALUES(?,?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, database)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ? LIMIT 1 
        SQL
        database.execute(sql, id).map do |row|
            poke_hash = {name: row[1], type: row[2], id: row[0], db: database}
            new_obj = Pokemon.new(poke_hash)
        end.first
    end
end
