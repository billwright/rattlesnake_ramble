module ApplicationHelper
  def gravatar_for(racer, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(racer.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"

    image_tag(gravatar_url, alt: racer.name, class: "gravatar")
  end

  def datepicker_input(args)
    form = args[:form]
    field = args[:field]
    existing_date = args[:existing_date]
    default_date = args[:default_date]
    default_view = args[:default_view]
    start_view = existing_date ? 'day' : default_view
    form.text_field field,
                    value: existing_date&.strftime('%m/%d/%Y'),
                    class: 'datepicker',
                    placeholder: 'mm/dd/yyyy',
                    data: {provide: 'datepicker', date_default_view_date: default_date, date_start_view: start_view}
  end
end
