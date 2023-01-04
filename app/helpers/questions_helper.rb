module QuestionsHelper
  def display_hashtags(tag)
    link_to"##{tag.body}", "/questions/hashtags/#{tag.body}"
  end
end
