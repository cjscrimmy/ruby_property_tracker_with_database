require('pg')

class Properties

    attr_accessor :address, :value, :number_of_bedrooms, :year_built
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @address = options['address']
        @value = options['value'].to_i
        @number_of_bedrooms = options['number_of_bedrooms'].to_i
        @year_built = options['year_built']
    end

# 1. Full CRUD functionality

    def save()
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "INSERT INTO properties
                (address,
                value,
                number_of_bedrooms,
                year_built)
                VALUES
                ($1, $2, $3, $4)
                RETURNING *;"
        values = [@address, @value, @number_of_bedrooms, @year_built]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]['id'].to_i
        db.close()
    end

    def Properties.all()
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "SELECT * FROM properties;"
        db.prepare("all", sql)
        properties = db.exec_prepared("all")
        db.close()
        return properties.map {|property| Properties.new(property)} 
    end

    def Properties.delete_all()
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "DELETE FROM properties;"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

    def delete()
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "DELETE FROM properties
        WHERE id = $1"
        values = [@id]
        db.prepare("delete_one", sql)
        db.exec_prepared("delete_one", values)
        db.close()
    end

    def update()
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "UPDATE properties
        SET
        (
            address,
            value,
            number_of_bedrooms,
            year_built
        ) = (
            $1, $2, $3, $4
        ) WHERE id = $5"
        values = [@address, @value, @number_of_bedrooms, @year_built, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close
    end

    # 2. The ability to find properties by id
    # Implement a `find` method that returns one instance of your class when an id is passed in.

    def Properties.find_by_id(id_to_find)
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "SELECT * FROM properties
        WHERE id = $1"
        values = [id_to_find]
        db.prepare("find_by_id", sql)
        p = db.exec_prepared("find_by_id", values)
        db.close()
        return p.map {|p| Properties.new(p)} 
    end

    # 3. The ability to find properties by address
    def Properties.find_by_address(address_to_find)
        db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
        sql = "SELECT * FROM properties
        WHERE address = $1"
        values = [address_to_find]
        db.prepare("find_by_id", sql)
        p = db.exec_prepared("find_by_id", values)
        db.close()
        return p.map {|p| Properties.new(p)} 
    end
end