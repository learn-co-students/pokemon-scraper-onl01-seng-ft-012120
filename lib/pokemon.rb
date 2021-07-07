class Pokemon
    
    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @db = db
        @name = name
        @type = type
    end

    def self.save(name, type, db)
        db.execute('INSERT INTO pokemon (name, type) VALUES ( ?, ?)', name, type)
        @id = db.execute('SELECT last_insert_rowid() FROM pokemon')[0][0]
    end


    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            SQL
        row = db.execute(sql, id)[0]
        self.new(id: row[0], name:row[1], type:row[2], db: db)
    end
end
