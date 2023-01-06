class TagsController < ApplicationController
  def show
    tag = Tag.find_by!(body: params[:body])
    @questions = tag.questions
  end
end