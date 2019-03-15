module UsersHelper
  def show_hobbies(user)
    raw("<ul>" + user.hobbies.to_s.split('|').map{ |x| "<li>" + x + "</li>" }.join('') + "</ul>")
  end

  def show_small_hobbies(user)
    hb = user.hobbies.to_s.size > 120 ? user.hobbies.mb_chars[0..119].to_s + '...' : user.hobbies.to_s
    raw("<span>" + hb.split('|').join('</span><span>') + "</span>")
  end
end
