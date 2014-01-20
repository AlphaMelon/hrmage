module PageMacros
  def top_bar
    #page.find("#topbar")
  end

  def data_obj(name,value)
    page.find(:xpath, "//*[@data-#{name}='#{value}']")
  end

end
