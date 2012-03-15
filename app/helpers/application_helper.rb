module ApplicationHelper
  
  def null_js
    "javascript:;"
  end
  
  def html_space(num_spaces=1)
    spaces = ""
    num_spaces.to_int.times do
      spaces << '&nbsp;'
    end
    spaces.html_safe
  end
end
