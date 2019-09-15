open Belt;
open Types;

module Styles = {
  open Emotion;

  let teamBanner = ({primary_color, logo_url}) =>
    css([
      display(block),
      unsafe("backgroundColor", primary_color),
      color("fff"->hex),
      unsafe("backgroundImage", {j|url("$logo_url")|j}),
    ]);
};

type state = {
  homeTeam: option(football_team),
  awayTeam: option(football_team),
  game: option(game_state),
};

let initialState = {
  homeTeam: TeamData.teams->Array.get(0),
  awayTeam: TeamData.teams->Array.get(0),
  game: None,
};

type action =
  | GameEventOccurred(game_event)
  | SetHomeTeam(option(football_team))
  | SetAwayTeam(option(football_team))
  | CreateGame(game_state);

let reducer = (state, action) =>
  switch (action) {
  | SetHomeTeam(value) => {...state, homeTeam: value}
  | SetAwayTeam(value) => {...state, awayTeam: value}
  | CreateGame(game) => {...state, game: Some(game)}
  | GameEventOccurred((EndOfGame, _, _, _)) => {...state, game: None}
  | GameEventOccurred(event) =>
    switch (state.game) {
    | Some(game) => {...state, game: Some(Api.new_game_event(game, event))}
    | None => state
    }
  };

let makeGame = (homeTeam, awayTeam) => Api.new_game(homeTeam, awayTeam);

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  let handleCreateGame = _event =>
    switch (state.homeTeam, state.awayTeam) {
    | (Some(homeTeam), Some(awayTeam)) =>
      dispatch(CreateGame(makeGame(homeTeam, awayTeam)))
    | _ => ()
    };

  let handleEndGame = _event =>
    switch (state.game) {
    | Some(_) => dispatch(GameEventOccurred((EndOfGame, None, None, None)))
    | None => ()
    };

  let handleSelectHomeTeam = event => {
    let abbreviation =
      Js.Undefined.toOption(event->ReactEvent.Form.target##value);

    switch (abbreviation) {
    | Some(abbr) =>
      dispatch(
        SetHomeTeam(TeamData.getByAbbreviation(abbr, TeamData.teams)),
      )
    | None => ()
    };
  };

  let handleSelectAwayTeam = event => {
    let abbreviation =
      Js.Undefined.toOption(event->ReactEvent.Form.target##value);

    switch (abbreviation) {
    | Some(abbr) =>
      dispatch(
        SetAwayTeam(TeamData.getByAbbreviation(abbr, TeamData.teams)),
      )
    | None => ()
    };
  };

  <div>
    <h1> "Home Team"->React.string </h1>
    <select
      onChange=handleSelectHomeTeam disabled={Option.isSome(state.game)}>
      {TeamData.teams
       ->Array.map(team =>
           <option key={team.abbreviation} value={team.abbreviation}>
             team.name->React.string
           </option>
         )
       ->React.array}
    </select>
    <h1> "Away Team"->React.string </h1>
    <select
      onChange=handleSelectAwayTeam disabled={Option.isSome(state.game)}>
      {TeamData.teams
       ->Array.map(team =>
           <option key={team.abbreviation} value={team.abbreviation}>
             team.name->React.string
           </option>
         )
       ->React.array}
    </select>
    <div>
      <br />
      <br />
      <button
        disabled={
          Option.isSome(state.game)
          || Option.isNone(state.homeTeam)
          || Option.isNone(state.awayTeam)
        }
        onClick=handleCreateGame>
        "Create Game"->React.string
      </button>
    </div>
    {switch (state.game) {
     | Some(game) =>
       let homeTeam = game.home_team;
       let awayTeam = game.away_team;
       <div>
         <h1> "Game on!"->React.string </h1>
         <h2 className={Styles.teamBanner(awayTeam)}>
           awayTeam.name->React.string
         </h2>
         <h2> "VERSUS"->React.string </h2>
         <h2 className={Styles.teamBanner(homeTeam)}>
           homeTeam.name->React.string
         </h2>
         <button disabled={Option.isNone(state.game)} onClick=handleEndGame>
           "End Game"->React.string
         </button>
       </div>;
     | None => React.null
     }}
  </div>;
};

let default = make;
