class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id 
  
  def initialize(name:, type:, db:, id: nil)
    @name = name 
    @type = type
    @db = db 
    @id = id
  end
  
  def self.new_from_db(row, db)
    id = row[0]
    name = row[1]
    type = row[2]
    db = db
    self.new(name: name, type: type, db: db, id: id)
  end 
    
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type) VALUES(?, ?)
    SQL
    db.execute(sql, name, type)
  end 
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
    SQL
    result = db.execute(sql, id)[0]
    self.new_from_db(result, db)
  end 
  
end