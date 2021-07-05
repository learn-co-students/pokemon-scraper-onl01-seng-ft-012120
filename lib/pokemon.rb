class Pokemon
  attr_accessor :id, :name, :type, :db
  
  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name 
    @type = type
    @db = db
  end 
  
  def self.new_by_name(row)
    id = row[0]
    name = row[1]
    type = row[2]
     Pokemon.new(id, name, type) 
   end 
    
  def self.save(pk_name, pk_type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    
    db.execute(sql, pk_name, pk_type)
    
  end 
  
  def self.find(ids, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    
   pokemon = db.execute(sql, ids).flatten
   Pokemon.new(id: pokemon[0], name: pokemon[1],type: pokemon[2], db: db)
   
  end 
    
  
end 
