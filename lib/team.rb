class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(teams_info, stats)
    @team_id      = teams_info[:team_id]
    @franchise_id  = teams_info[:franchiseid]
    @team_name     = teams_info[:teamname].to_s
    @abbreviation = teams_info[:abbreviation]
    @stadium      = teams_info[:stadium]
    @link         = teams_info[:link]
    @stats = stats
  end

  def games
    @stats.find_games_by_team_id(team_id)
  end
end
