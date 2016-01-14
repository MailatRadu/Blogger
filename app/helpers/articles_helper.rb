module ArticlesHelper
	def article_params 
		params.require(:article).permit(:title, :body, :tag_list, :image, :created_at)
	end

end
