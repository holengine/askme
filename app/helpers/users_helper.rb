module UsersHelper
  def display_nickname(user)
    "@#{user.nickname}"
  end

  def color_theme(user)
    if user.present?
      user.theme_color
    else
      '#370617'
    end
  end
end