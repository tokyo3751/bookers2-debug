class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
    @book_comment = BookComment.new
  end

  def index
    @user = current_user
    @books = Book.all.sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title,:body)
    end

    def correct_user
       @book = Book.find(params[:id])
       unless @book.user == current_user
         redirect_to books_path
       end
    end
end