module MtDnaSeqsHelper
  def sequence_column(record)
    content_tag :div, record.sequence
  end
end
