module UsersHelper
  def gravatar_for(user, size: 80)
    digest = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
    image_tag(url, alt: user.name, class: "gravatar")
  end
end
