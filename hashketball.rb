require "pry"

def game_hash
  game = {
  :home => { 
    :team_name => "Brooklyn Nets",
    :colors => ["Black", "White"],
    :players => {
      "Alan Anderson" => {
        :number => 0,
        :shoe => 16, 
        :points => 22, 
        :rebounds => 12, 
        :assists => 12, 
        :steals => 3, 
        :blocks => 1, 
        :slam_dunks => 1},
      "Reggie Evans" => {
        :number => 30,
        :shoe => 14, 
        :points => 12, 
        :rebounds => 12, 
        :assists => 12, 
        :steals => 12, 
        :blocks => 12, 
        :slam_dunks => 7},
      "Brook Lopez" => {
        :number => 11,
        :shoe => 17, 
        :points => 17, 
        :rebounds => 19, 
        :assists => 10, 
        :steals => 3, 
        :blocks => 1, 
        :slam_dunks => 15},
      "Mason Plumlee" => {
        :number => 1,
        :shoe => 19, 
        :points => 26, 
        :rebounds => 11, 
        :assists => 6, 
        :steals => 3, 
        :blocks => 8, 
        :slam_dunks => 5},
      "Jason Terry" => {
        :number => 31,
        :shoe => 15, 
        :points => 19, 
        :rebounds => 2, 
        :assists => 2, 
        :steals => 4, 
        :blocks => 11, 
        :slam_dunks => 1}
      }
    },
  :away => {
    :team_name => "Charlotte Hornets",
    :colors => ["Turquoise", "Purple"],
    :players => {
      "Jeff Adrien" => {
        :number => 4,
        :shoe => 18, 
        :points => 10, 
        :rebounds => 1, 
        :assists => 1, 
        :steals => 2, 
        :blocks => 7, 
        :slam_dunks => 2},
      "Bismack Biyombo" => {
        :number => 0,
        :shoe => 16, 
        :points => 12, 
        :rebounds => 4, 
        :assists => 7, 
        :steals => 22, 
        :blocks => 15, 
        :slam_dunks => 10},
      "DeSagna Diop" => {
        :number => 2,
        :shoe => 14, 
        :points => 24, 
        :rebounds => 12, 
        :assists => 12, 
        :steals => 4, 
        :blocks => 5, 
        :slam_dunks => 5},
      "Ben Gordon" => {
        :number => 8,
        :shoe => 15, 
        :points => 33, 
        :rebounds => 3, 
        :assists => 2, 
        :steals => 1, 
        :blocks => 1, 
        :slam_dunks => 0},
      "Kemba Walker" => {
        :number => 33,
        :shoe => 15, 
        :points => 6, 
        :rebounds => 12, 
        :assists => 12, 
        :steals => 7, 
        :blocks => 5, 
        :slam_dunks => 12}
      }
    }
  }
end

def num_points_scored(player_name)
  game_hash.each { |team, team_data|
    if team_data[:players].include? (player_name)
      return team_data[:players][player_name][:points]
    end
  }
end

def shoe_size(player_name)
  game_hash.each { |team, team_data|
    if team_data[:players].include? (player_name)
      return team_data[:players][player_name][:shoe]
    end
  }
end

def team_colors(team_name)
  game_hash.each { |team, team_data|
    if (team_data[:team_name] == team_name)
      return team_data[:colors]
    end
  }
end

def team_names
  game_hash.reduce([]) { |memo, (team, team_data)|
    memo.push(team_data[:team_name])
  }
end

def player_numbers(team_name)
  game_hash.reduce([]) { |memo, (team, team_data)|
    if team_data[:team_name] == team_name
      team_data[:players].each { |(player_name, player_stats)|
        memo.push(player_stats[:number]).sort
      }
    end
    memo
  }
end

def player_stats(player_name)
  game_hash.each {|team, team_data|
    if team_data[:players].include? (player_name)
      return team_data[:players][player_name]
    end
  }
end

def big_shoe_rebounds
  shoe_rebound = {:shoe => 0, :rebounds => 0}
  game_hash.each {|team, team_data|
    binding.pry
    team_data[:players].each{ |player, player_stats|
      if player_stats[:shoe] > shoe_rebound[:shoe]
        shoe_rebound[:shoe] = player_stats[:shoe]
        shoe_rebound[:rebounds] = player_stats[:rebounds]
      end
    }
  }
  shoe_rebound[:rebounds]
end 

def most_points_scored
  highest_points = {:player_name => "", :points => 0}
  game_hash.each {|team, team_data|
    team_data[:players].each{ |player, player_stats|
      if player_stats[:points] > highest_points[:points]
        highest_points[:points] = player_stats[:points]
        highest_points[:player_name] = player
      end
    }
  }
  highest_points[:player_name]
end

def winning_team
  total_points = {:home => {}, :away => {}}
  game_hash.each{|team, team_data|
    if !total_points[team].include? (team_data[:team_name])
      total_points[team] = {
        :team_name => team_data[:team_name],
        :points => 0
      }
    end
    team_data[:players].each{ |player, player_stats|
      total_points[team][:points] += player_stats[:points]
    }
  }
  total_points[:home][:points] > total_points[:away][:points] ? total_points[:home][:team_name] : total_points[:away][:team_name]
end 

def player_with_longest_name
  game_hash.reduce("") {|longest_name, (team, team_data)|
    team_data[:players].each{ |player, player_stats|
      if player.length > longest_name.length
        longest_name = player
      end
    }
    longest_name
  }
end

def long_name_steals_a_ton?
  ### find the person withthe longest name and their number of steals
  longest_player = game_hash.reduce({}) {|name, (team, team_data)|
    team_data[:players].each{ |player, player_stats|
      if player == player_with_longest_name
        name = {
          :name => player,
          :steals => player_stats[:steals],
          :most_steals => true
        }
      end
    }
    name
  }
  
  game_hash.each { |team, team_data|
    team_data[:players].each { |player, player_stats|
      if player != longest_player[:name] && player_stats[:steals] > longest_player[:steals]
        longest_player[:most_steals] = false
      end
    }
  }
  longest_player[:most_steals]
end
