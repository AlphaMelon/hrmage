class NoOrYesInput < SimpleForm::Inputs::StringInput
  # This method only create a basic input without reading any value from object
  def input
    template.select_tag(attribute_name,
    template.options_for_select([["No", false],["Yes", true]]),
    input_html_options)
  end

end
