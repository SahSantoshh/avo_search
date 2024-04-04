class Avo::Dashboards::Overview < Avo::Dashboards::BaseDashboard
  self.id = "overview"
  self.name = "Overview"
  # self.description = "Tiny dashboard description"
  # self.grid_cols = 3
  # self.visible = -> do
  #   true
  # end

  def cards
    card ProvidersMetric
  end
end
