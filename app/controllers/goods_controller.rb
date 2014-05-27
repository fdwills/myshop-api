class GoodsController < ApplicationController
  get '' do
    @goods = Good.all
    jbuilder :'goods/index'
  end

  get '/:id' do |id|
    @good = Good.find_by_id(id)
    jbuilder :'goods/show'
  end

end
