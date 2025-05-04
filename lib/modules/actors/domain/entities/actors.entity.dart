class Actor {
  //#region ----------------------------------- Variables ---------------------------------

  final int id;
  final String name;
  final String profilePath;
  final String? character;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });

  //#endregion
}
