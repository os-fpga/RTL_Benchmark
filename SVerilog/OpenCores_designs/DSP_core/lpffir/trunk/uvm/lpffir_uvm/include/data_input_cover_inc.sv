covergroup m_cov;
  option.per_instance = 1;

  cp_data: coverpoint m_item.data {
    bins data_values[] = {[0:127]};
  }
endgroup
