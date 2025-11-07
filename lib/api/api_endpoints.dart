class ApiEndPoints {
  static final String login = 'auth/login'; // post

  static final String register = 'auth/register'; // post

  static final String reset_password =
      'auth/reset-password'; // PATCH  with send AUTHORIZATION 'token' in Bearer Token

  static final String addFavourite = 'favorites/add'; // post

  static final String getAllFavourites = 'favorites/all'; // get

  static final String deleteMovie =
      'favorites/remove/movieId'; // delete = 'auth/login';
  static final String movieIsFavourite = 'favorites/is-favorite/movieId'; //GET

  static final String updateProfile =
      'profile'; // can do post and get profile info and delete profile
}
