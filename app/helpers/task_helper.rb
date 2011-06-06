module TaskHelper
  def to_date(date_data)
    date_data.to_formatted_s(:long)
  end
end
