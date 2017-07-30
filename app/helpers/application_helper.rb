module ApplicationHelper
  
  def gravatar_for(racer, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(racer.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    
    image_tag(gravatar_url, alt: racer.name, class: "gravatar")
  end
  
end
