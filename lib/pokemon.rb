#require_relative "../config/environment.rb"

class Pokemon
    attr_accessor :name, :type
  attr_reader :id, :db

  def initialize(id:, name:, type:, db:)
    @id = id
    @db = db
    self.name = name
    self.type = type
  end

    def self.save(name, type, db)
        # if self.id    #<<<<<<<<<<Refactoring our #save Method to Avoid Duplication**************
        #     self.update
        # else
            sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
            SQL
     
            db.execute(sql,name, type)
            @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
        # end
    end

    def self.new_from_db(row, db)
        new_pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db)  
        new_pokemon 
    end
    
    def self.all
        sql = <<-SQL
            SELECT * FROM pokemon
         SQL
        db.execute(sql).map do |row|
            self.new_from_db(row)
        end
                
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL
 
        db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first
    end


end
