class Avo::Dashboards::Overview < Avo::Dashboards::BaseDashboard
  self.id = 'overview'
  self.name = 'Overview'
  # self.description = "Tiny dashboard description"
  self.grid_cols = 5

  # self.visible = -> do
  #   true
  # end

  def cards
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    divider label: 'Sales'
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    divider label: 'Sales 2'
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    divider label: 'Sales 3'
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    divider label: 'Sales 4'
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
    card Avo::Cards::ProvidersMetric
  end
end
