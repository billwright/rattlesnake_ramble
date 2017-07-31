class ProductsController < ApplicationController

  def index
    @products = Product.all
  end
  
    def show
    @product = Product.find(params[:id])
    # binding.pry
  end
  
  def new
    @product = Product.new
  end
  
  def create
    # binding.pry
    @product = Product.new(recipe_params)
    
    if @product.save
      flash[:success] = "Your product was created successfully!"
      redirect_to products_path
    else
      render :new
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update(recipe_params)
      flash[:success] = "Your product was updated successfully"
      redirect_to product_path(@product)
    end
  end
  
  private
  
    def recipe_params
      params.require(:product).permit(:name, :description)
    end
end