module ApplicationHelper
  def nl2br(str)
    str.gsub(/\n/, '<br />')
  end
end
