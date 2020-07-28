

class GameTeams

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways

  def initialize(game_teams_info)

    @game_id                = game_teams_info[:game_id].to_i
    @team_id                = game_teams_info[:team_id].to_i
    @hoa                    = game_teams_info[:hoa]
    @result                 = game_teams_info[:result]
    @settled_in             = game_teams_info[:settled_in]
    @head_coach             = game_teams_info[:head_coach]
    @goals                  = game_teams_info[:goals].to_i
    @shots                  = game_teams_info[:shots].to_i
    @tackles                = game_teams_info[:tackles].to_i
    @pim                    = game_teams_info[:pim].to_i
    @powerplayopportunities = game_teams_info[:powerplayopportunities].to_i
    @powerplaygoals         = game_teams_info[:powerplaygoals].to_i
    @faceoffwinpercentage   = game_teams_info[:faceoffwinpercentage].to_f
    @giveaways              = game_teams_info[:giveaways].to_i
    @takeaways              = game_teams_info[:takeaways].to_i
  end

end
