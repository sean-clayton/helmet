type points = int
type yards = int
type yard_line = int

type game_clock = int
type game_clock_state =
  | Stopped
  | Running

type play_clock = int
type play_clock_state =
  | Stopped
  | Running

type line_of_scrimmage =
  | HomeTeamField of yard_line
  | AwayTeamField of yard_line
  | Midfield

type football_team = {
  (* eg. Los Angeles Chargers *)
  name: string;
  (* eg. Chargers *)
  nickname: string;
  (* eg. LAC *)
  abbreviation: string;
  (* eg. #09f *)
  primary_color: string;
  (* eg. #09f *)
  secondary_color: string;
  logo_url: string;
}

type quarter =
  | FirstQuarter
  | SecondQuarter
  | ThirdQuarter
  | FourthQuarter
  | Overtime
  | PlayoffOvertimeQuarter

type team =
  | HomeTeam
  | AwayTeam

type scoring_play =
  | Touchdown
  | ExtraPoint
  | TwoPointConversion
  | Safety
  (* OMEGALUL if this ever happens *)
  | OnePointSafety

type distance =
  | Yards of yards
  | Goal
  | Inches

type down =
  | FirstDown
  | SecondDown
  | ThirdDown
  | FourthDown

type penalty_code = | CHB | CLP | DOD | DH | DOF | DPI | DTM | DOG | DOK | DSQ | ENC | FMM | FCI | FST | HC | BAT | BLI | IBW | ICT | ICB | ICU | IDT | ILF | IFH | IFP | KIK | ILM | IPB | ISH | ILS | ITK | ITP | ILH | IDK | IDP | ING | IFC | KOB | LEA | LEV | LBL | NZI | OH | OOF | OPI | OTM | OFK | POK | RRK | RPS | RNK | SFK | TAU | TRP | UNR | UNS | UOH

type down_and_distance = {
  down: down;
  distance: distance;
}

type penalty = {
  team: team;
  penalty_code: penalty_code;
  down_and_distance: down_and_distance;
  game_clock: game_clock;
}

type flag =
  | FlagOnField
  | Penalty of penalty

type challenge = string

type play =
  | ChangeOfPossession
  | TurnoverOnDowns
  | TurnoverAndScore of scoring_play
  | Down
  | UntimedDown
  | Kickoff
  | Punt
  | Score of scoring_play

type game_event_type =
  | StartGame
  | StartGameClock
  | StopGameClock
  | StartPlayClock
  | StopPlayClock
  | Tick
  | Flag of flag
  | Play of team * play
  | BoothReview of challenge
  | CoachesChallenge of challenge
  | Timeout of team
  | EndOfQuarter
  | TwoMinuteWarning
  | EndOfHalf
  | EndOfRegulation
  | EndOfPlayoffOvertimeQuarter
  | EndOfGame

type game_event = {
  game_event: game_event_type;
  new_line_of_scrimmage: line_of_scrimmage option;
  new_down_and_distance: down_and_distance option;
  new_game_clock: game_clock option;
}

type game_state = {
  home_team: football_team;
  away_team: football_team;
  home_team_score: points;
  away_team_score: points;
  home_team_timeouts_remaining: int;
  away_team_timeouts_remaining: int;
  game_events: game_event list;
  play_clock: play_clock;
  game_clock: game_clock;
  quarter: quarter;
  play_clock_state: play_clock_state;
  game_clock_state: game_clock_state;
}
