open Types

let new_set_of_downs: down_and_distance = {
  down = FirstDown;
  distance = Yards 10;
}

let score_of_scoring_play = function
  | Touchdown -> 6
  | ExtraPoint -> 1
  | TwoPointConversion -> 2
  | Safety -> 2
  | OnePointSafety -> 1

let string_of_down = function
  | FirstDown -> "1st"
  | SecondDown -> "2nd"
  | ThirdDown -> "3rd"
  | FourthDown -> "4th"

let string_of_distance = function
  | Yards i -> string_of_int i
  | Goal -> "Goal"
  | Inches -> "Inches"

let string_of_down_and_distance (down, distance) =
  string_of_down down ^ " & " ^ string_of_distance distance

let new_game_event state game_event = { state with
  game_events = (game_event :: (state.game_events));
}

let time_of_quarter = function
  | FirstQuarter -> 900
  | SecondQuarter -> 900
  | ThirdQuarter -> 900
  | FourthQuarter -> 900
  | Overtime -> 600
  | PlayoffOvertimeQuarter -> 900

let string_of_penalty_code = function
  | CHB -> "CHB"
  | CLP -> "CLP"
  | DOD -> "DOD"
  | DH -> "DH"
  | DOF -> "DOF"
  | DPI -> "DPI"
  | DTM -> "DTM"
  | DOG -> "DOG"
  | DOK -> "DOK"
  | DSQ -> "DSQ"
  | ENC -> "ENC"
  | FMM -> "FMM"
  | FCI -> "FCI"
  | FST -> "FST"
  | HC -> "HC"
  | BAT -> "BAT"
  | BLI -> "BLI"
  | IBW -> "IBW"
  | ICT -> "ICT"
  | ICB -> "ICB"
  | ICU -> "ICU"
  | IDT -> "IDT"
  | ILF -> "ILF"
  | IFH -> "IFH"
  | IFP -> "IFP"
  | KIK -> "KIK"
  | ILM -> "ILM"
  | IPB -> "IPB"
  | ISH -> "ISH"
  | ILS -> "ILS"
  | ITK -> "ITK"
  | ITP -> "ITP"
  | ILH -> "ILH"
  | IDK -> "IDK"
  | IDP -> "IDP"
  | ING -> "ING"
  | IFC -> "IFC"
  | KOB -> "KOB"
  | LEA -> "LEA"
  | LEV -> "LEV"
  | LBL -> "LBL"
  | NZI -> "NZI"
  | OH -> "OH"
  | OOF -> "OOF"
  | OPI -> "OPI"
  | OTM -> "OTM"
  | OFK -> "OFK"
  | POK -> "POK"
  | RRK -> "RRK"
  | RPS -> "RPS"
  | RNK -> "RNK"
  | SFK -> "SFK"
  | TAU -> "TAU"
  | TRP -> "TRP"
  | UNR -> "UNR"
  | UNS -> "UNS"
  | UOH -> "UOH"

let penalty_code_name = function
  | CHB -> "Chop Block"
  | CLP -> "Clipping"
  | DOD -> "Defensive Delay of Game"
  | DH -> "Defensive Holding"
  | DOF -> "Defensive Offside"
  | DPI -> "Defensive Pass Interference"
  | DTM -> "Defensive Too Many Men on Field"
  | DOG -> "Delay of Game"
  | DOK -> "Delay of Kickoff"
  | DSQ -> "Disqualification"
  | ENC -> "Encroachment"
  | FMM -> "Facemask"
  | FCI -> "Fair Catch Interference"
  | FST -> "False Start"
  | HC -> "Horse Collar"
  | BAT -> "Illegal Bat"
  | BLI -> "Illegal Blindside Block"
  | IBW -> "Illegal Block Above the Waist"
  | ICT -> "Illegal Contact"
  | ICB -> "Illegal Crackback"
  | ICU -> "Illegal Cut"
  | IDT -> "Illegal Double Team Block"
  | ILF -> "Illegal Formation"
  | IFH -> "Illegal Forward Handing"
  | IFP -> "Illegal Forward Pass"
  | KIK -> "Illegal Kick/Kicking Loose Ball"
  | ILM -> "Illegal Motion"
  | IPB -> "Illegal Peel Back"
  | ISH -> "Illegal Shift"
  | ILS -> "Illegal Substitution"
  | ITK -> "Illegal Touch—Kick"
  | ITP -> "Illegal Touch—Pass"
  | ILH -> "Illegal Use of Hands"
  | IDK -> "Ineligible Downfield Kick"
  | IDP -> "Ineligible Downfield Pass"
  | ING -> "Intentional Grounding"
  | IFC -> "Invalid Fair Catch Signal"
  | KOB -> "Kickoff Out of Bounds"
  | LEA -> "Leaping"
  | LEV -> "Leverage"
  | LBL -> "Low Block"
  | NZI -> "Neutral Zone Infraction"
  | OH -> "Offensive Holding"
  | OOF -> "Offensive Offside"
  | OPI -> "Offensive Pass Interference"
  | OTM -> "Offensive Too Many Men on Field"
  | OFK -> "Offside on Free Kick"
  | POK -> "Player Out of Bounds on Kick"
  | RRK -> "Roughing the Kicker"
  | RPS -> "Roughing the Passer"
  | RNK -> "Running into the Kicker"
  | SFK -> "Short Free Kick"
  | TAU -> "Taunting"
  | TRP -> "Tripping"
  | UNR -> "Unnecessary Roughness"
  | UNS -> "Unsportsmanlike Conduct"
  | UOH -> "Use of Helmet"

let get_football_team_from_game_team game = function
  | HomeTeam -> game.home_team
  | AwayTeam -> game.away_team

let new_game home_team away_team = {
  home_team = home_team;
  away_team = away_team;
  home_team_score = 0;
  away_team_score = 0;
  home_team_timeouts_remaining = 3;
  away_team_timeouts_remaining = 3;
  game_events = [];
  play_clock = 40;
  quarter = FirstQuarter;
  game_clock = 900;
  game_clock_state = Stopped;
  play_clock_state = Stopped;
}

let game_loop game event =
  match event with
  | Tick -> game
  | _ -> game
