module ApplicationHelper
  def format_date(date)
    date.strftime("%d/%m/%Y")
  rescue
    "Não informado"
  end
end
