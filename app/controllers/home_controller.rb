class HomeController < ApplicationController
  def index
    @company = Company.last
    @products = Product.last(limit = 5)
    @customers = Customer.last(limit = 5)
  end
end
