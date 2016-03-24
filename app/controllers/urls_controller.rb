class UrlsController < ApplicationController
	def index
		@urls = Url.all
	end

	def show
		if params[:short]
      @url = Url.find_by(short: params[:short])
      if redirect_to @url.long
        @url.visits += 1
        @url.save
      end
    else
      	@url = Url.find(params[:id])
    end
	end

	def new
		@url = Url.new
	end

	def create
		@url = Url.new(url_params)
		if @url.save
			respond_to do |format|
        format.html { render @url, layout: false }
        format.json { render json: @url }
        format.js { }
      end
		else
			redirect_to '/'
		end
	end

	private
		def url_params
			params.require(:url).permit(:long)
		end
end