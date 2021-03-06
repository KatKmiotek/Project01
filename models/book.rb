require_relative('../db/sql_runner')
require_relative('./user')

class Book

attr_reader :id
attr_accessor :title, :status, :location, :comment, :author, :language, :user_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @author = options['author']
  @status = options['status']
  @location = options['location']
  @language = options['language']
  @comment = options['comment']
  @user_id = options['user_id'].to_i
end

def save()
  sql = "INSERT INTO books(title, author, status, location, language, comment, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"
  values = [@title, @author, @status, @location, @language, @comment, @user_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE books SET(title, author, status, location, language, comment, user_id) = ($1, $2, $3, $4, $5, $6, $7)
  WHERE id = $8"
  values =[@title, @author, @status, @location, @language, @comment, @user_id, @id]
  SqlRunner.run(sql, values)
end

def delete_by_id()
  sql = "DELETE FROM books WHERE id = $1"
  values= [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM books"
  SqlRunner.run(sql)
end

def self.find_all()
  sql = "SELECT * FROM books"
  result = SqlRunner.run(sql)
  books = result.map { |book| Book.new(book) }
  return books
end

def self.find_by_id(id)
  sql = "SELECT * FROM books WHERE id = $1"
  values =[id]
  result = SqlRunner.run(sql, values)
  return Book.new(result.first)
end
# general book collection sorting - can be used in future 
def self.find_all_by_author()
  sql = "SELECT * FROM books ORDER BY author"
  result = SqlRunner.run(sql)
  books = result.map { |book| Book.new(book) }
  return books
end

def self.find_all_by_status()
  sql = "SELECT * FROM books ORDER BY status DESC"
  result = SqlRunner.run(sql)
  books = result.map { |book| Book.new(book) }
  return books
end

def self.find_all_by_location()
  sql = "SELECT * FROM books ORDER BY location DESC"
  result = SqlRunner.run(sql)
  books = result.map { |book| Book.new(book) }
  return books
end

def self.find_all_by_title()
  sql = "SELECT * FROM books ORDER BY title"
  result = SqlRunner.run(sql)
  books = result.map { |book| Book.new(book) }
  return books
end
# general search function - can be used in future
def self.search(input)
  sql = "SELECT * FROM books WHERE (lower(author) LIKE $1) OR (lower(title) LIKE $1) OR (lower(comment) LIKE $1)"
  values = ["%#{input}%"]
  result = SqlRunner.run(sql, values)
  books = result.map { |book| Book.new(book) }
  return books
end

end
