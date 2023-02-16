class Api::V1::ProductsController < ApplicationController
  def show
    product = Product.find_by(id: params[:id])
    if product 
      render json: product,status:200
    else
      render json: {error: "Not Found !"}
    end
  end

  def index
    products = Product.all
    render json: products,status: 200
  end

  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price]
    )
    if product.save
      render json: product, status: 200
    else
      render json: {error: "Product not created!"}
    end
  end

  def update
    product = Product.find_by(id: params[:id])
    if product
      product.update(name: params[:name] , brand: params[:brand] , price: params[:price])
      render json: "Product has been updated!"
    else 
      render json: {
        error: "Product Not Found!"
      }
    end 
  end

  def destroy
    product = Product.find_by(id: params[:id])
    if product 
      product.destroy
      render json: "Product has been deleted!"
    else 
      render json: {
        error: "Product Not Found!"
      }
    end
  end

  private

  def prod_params
    params.require(:product).permit(
      [:name,:brand,:price]
    )
  end
end
