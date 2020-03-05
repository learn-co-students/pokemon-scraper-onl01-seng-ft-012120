class Pokemon

    attr_accessor :id, :name, :type, :db
    @@all = []

    def initialize(attributes)
        attributes.each{|key, value| self.send(("#{key}="), value)}
        @@all << self
    end

    def self.save(name, type, db)
         db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.find(id, db)
        row = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
        Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end
  end

