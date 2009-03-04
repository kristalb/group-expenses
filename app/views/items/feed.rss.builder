xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "House Items"
    xml.description "Latest items contributed to the house"
    xml.link items_url

    for item in @items
      xml.item do
        full_title = "#{item.title} (#{item.type}) for #{number_to_currency(item.amount)} - #{item.user.login.titleize}"
        xml.title full_title
        xml.description item.note
        xml.pubDate item.created_at.to_s(:rfc822)
        xml.link item_url(item)
      end
    end
  end
end