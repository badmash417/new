class PdfGenerator
  def self.generate_user_pdf_data(user)
    Prawn::Document.generate do
      text "User Details:"
      move_down 10
      text "First Name: #{user.first_name}"
      text "Last Name: #{user.last_name}"
      text "Role: #{user.role.name}"
      move_down 10
      text "PDF generated at: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
    end.render
  end
end