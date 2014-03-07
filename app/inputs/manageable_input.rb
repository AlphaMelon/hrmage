class ManageableInput < SimpleForm::Inputs::StringInput
  # This method only create a basic input without reading any value from object
  def input
    template.select_tag(attribute_name,
    template.options_for_select(["Read Only", "Read and Create", "Read and Update", "Manage all"]),
    input_html_options)
  end

end
