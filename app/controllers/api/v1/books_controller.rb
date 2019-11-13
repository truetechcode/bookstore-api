class Api::V1::BooksController < ApplicationController

  before_action :find_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all
    render json: @books
  end

  # GET /book/:id
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book
    else
      render error: {error: 'Unable to create book'}, status: 400
    end
  end

  # PUT /book/:id
  def update
    if @book
      @book.update(book_params)
      render json: {message: 'Book successfully updated.'}, status: 200
    else
      render json: {error: 'Unable to update book.'}, status: 400
    end
  end

  # DELETE /book/:id
  def destroy
    if @book
      @book.destroy
      render json: {message: 'Book successfully deleted.'}, status: 200
    else
      render json: {error: 'Unable to delete book'}, status: 400
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :category)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
