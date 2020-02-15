class Pokemon
  require 'pry'

  attr_accessor :name, :type
  attr_reader :id, :db

  def initialize(id:, name:, type:, db:)
    @id = id
    @db = db
    self.name = name
    self.type = type
  end

  def self.save(name, type, db)
    db.execute('INSERT INTO pokemon (name, type) VALUES ( ?, ?)', name, type)
    @id = db.execute('SELECT last_insert_rowid() FROM pokemon')[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    row = db.execute(sql, id)[0]
    self.new(id: row[0], name:row[1], type:row[2], db: db)
  end
end

