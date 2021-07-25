class Book
  attr_accessor :title, :author, :pages
  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
  end
end

book1 = Book.new("Harry Potter", "JK Rowling", 200)
book1 = Book.new("Lord of the rings", "Tolkein", 100)

puts book1.author
