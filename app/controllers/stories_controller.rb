class StoriesController < ApplicationController
  def top
  @start = (params[:start] || 0).to_i
  @per_page = (params[:per_page] || 10).to_i
  @per_page = [@per_page, 20].min # max 20 per page
  @stories = client.topstories(@start, @per_page)
end

  def topstories(start = 0, per_page = 10, expand = true)
  stories = get('topstories')[start...start + per_page]

  if expand
    stories.map! do |story|
      item(story)
    end
  end

  stories
end
end