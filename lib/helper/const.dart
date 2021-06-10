const FAILED_TO_CONNECT = "Failed connected to the server";
const NETWORK_UNREACHABLE = "Network is unreachable";
const DATA_EMPTY = "Data is empty";

const API_KEY = "563492ad6f9170000100000121d114319503435ca7128255c271aea0";

const String assCoverHonme = "assets/images/evermos_cover.jpg";

const String API_URL = 'https://api.pexels.com/v1/';

String apiCurated(int page, int perPage) {
  return "/curated?page=${page.toString()}&per_page=${perPage.toString()}";
}
