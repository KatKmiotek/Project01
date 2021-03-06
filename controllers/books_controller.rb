require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('../models/user')
require_relative('../models/book')
also_reload('./models')


# post '/collection' do
#   @books = User.books() #this line has been changed from @books = Book.find_all()
#   erb(:"books/index")
# end
post '/collection' do
  @user = User.find(1)
  erb(:"books/index")
end

get '/collection' do
  @user = User.find(1)
  erb(:"books/index")
end

get '/collection/:id' do
  @book = Book.find_by_id(params['id'].to_i)
  erb(:"books/show")
end

post '/new' do
  @users = User.find_all() #this line has been added
  erb(:new)
end
get '/new' do
  @users = User.find_all() #this line has been added
  erb(:new)
end

post '/create' do
   @book = Book.new(params)
   @book.save()
   redirect '/collection'
end

post '/collection/:id/delete' do
  @book = Book.find_by_id(params[:id])
  @book.delete_by_id
  erb(:delete)
end

get '/collection/:id/edit' do
  @users = User.find_all() #this line has been added

  @book = Book.find_by_id(params[:id])
  erb(:edit)
end

post '/collection/:id' do
  @users = User.find_all() #this line has been added

  @book = Book.new(params)
  @book.update()
  redirect '/collection'
end
#sorting:

get '/collection/byauthor/' do
    @user = User.find(1)
    erb(:"books/books_by_author")
end
get '/collection/bystatus/' do
  @user = User.find(1)
  erb(:"books/books_by_status")
end
get '/collection/bytitle/' do
  @user = User.find(1)
  erb(:"books/books_by_title")
end
get '/collection/bylocation/' do
  @user = User.find(1)
  erb(:"books/books_by_location")
end
get '/about' do
  erb(:about)
end

#search for general data
# post '/collection/search/' do
#   @books = Book.search(params[:search])
#   erb(:"books/search_result")
# end

#search in user's data
post '/collection/search/' do
  @user = User.find(1)
  erb(:"books/search_result")
end
