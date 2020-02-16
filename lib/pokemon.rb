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
      INSERT INTO Pokemon (name, type) 
      VALUES (?, ?)
    SQL
 
    db.execute(sql, name, type)
 
    @id = db.execute("SELECT last_insert_rowid() FROM Pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM Pokemon
      WHERE id = ?
    SQL
 
    monster = db.execute(sql, id)
    Pokemon.new({id:monster[0][0], name:monster[0][1], type:monster[0][2], db:db})
  end
end
