class BooksController < ApplicationController
  before_action :authenticate_user!, exept: [:top]
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    @books = Book.all
    if @book.save
      redirect_to book_path(@book.id), success: "You have created book successfully."
    else
      render :index
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), success: "You have updated book successfully."
    else
      render :edit
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
