class GoodsController < ApplicationController
  get '' do
    page = params[:page].to_i || 1
    ipp = params[:ipp].to_i || 5
    @goods = Good.released.recent.paginate(page, ipp)
    jbuilder :'goods/index'
  end

  get '/:id' do |id|
    @good = Good.find_by_id(id)
    jbuilder :'goods/show'
  end

end
