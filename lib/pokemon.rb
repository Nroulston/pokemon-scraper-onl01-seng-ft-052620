class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id
   def initialize(hash)
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
    @id = hash[:id]  
   end

   def self.save(name, type, db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?)
      SQL
  
      db.execute(sql, name, type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    end
    
    def self.find(id_num, db)
      pokemon_info = db.execute("SELECT * FROM pokemon WHERE id=?", id_num).flatten
      Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], db: db)

    end
    
end
