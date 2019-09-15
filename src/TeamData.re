[@bs.module] external teamDataRaw: Js.Array.t(Js.t('a)) = "./team-data.json";

let teams =
  teamDataRaw->Belt.Array.map(obj =>
    Types.{
      name: obj##name,
      abbreviation: obj##abbreviation,
      nickname: obj##nickname,
      logo_url: obj##logo_url,
      primary_color: obj##primary_color,
      secondary_color: obj##secondary_color,
    }
  );

let getByAbbreviation = (abbreviation, teams) =>
  Belt.Array.getBy(teams, team => abbreviation == Types.(team.abbreviation));
