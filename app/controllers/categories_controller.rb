class CategoriesController < ApplicationController
  def index
    # TODO : will_paginate
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
  end
end
