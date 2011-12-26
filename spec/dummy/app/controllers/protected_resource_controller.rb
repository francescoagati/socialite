class ProtectedResourceController < ApplicationController
  before_filter :ensure_authenticated

  def index
    render :text => 'index'
  end

  def show
    render :text => 'show'
  end
end
