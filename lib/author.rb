require 'fileutils'
require 'pry'

  class Author
    attr_accessor :name, :id
    def initialize(attributes)
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    def self.all
      returned_authors = DB.exec("SELECT * FROM authors ORDER BY name")
      authors = []
      returned_authors.each() do |author|
        name = author.fetch("name")
        id = author.fetch("id").to_i
        authors.push(Author.new({:name => name, :id => id}))
      end
      authors
    end

    def save
      result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i
    end

    
  end