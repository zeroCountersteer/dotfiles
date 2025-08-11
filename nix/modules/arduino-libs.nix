{ config, pkgs, lib, ... }:
let
  arduinoLibs = {
    Adafruit_BME280_Library = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit_BME280_Library"; rev = "2.2.4"; sha256 = lib.fakeSha256;
    };
    Adafruit_BusIO = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit_BusIO"; rev = "1.17.2"; sha256 = lib.fakeSha256;
    };
    Adafruit_GFX_Library = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit-GFX-Library"; rev = "1.12.1"; sha256 = lib.fakeSha256;
    };
    Adafruit_SSD1306 = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit_SSD1306"; rev = "2.5.15"; sha256 = lib.fakeSha256;
    };
    Adafruit_Unified_Sensor = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit_Sensor"; rev = "1.1.15"; sha256 = lib.fakeSha256;
    };
    Adafruit_XCA9554 = pkgs.fetchFromGitHub {
      owner = "adafruit"; repo = "Adafruit_xCA9554"; rev = "1.0.0"; sha256 = lib.fakeSha256;
    };
    Arduino_JSON = pkgs.fetchFromGitHub {
      owner = "arduino-libraries"; repo = "Arduino_JSON"; rev = "0.2.0"; sha256 = lib.fakeSha256;
    };
    ArduinoJson = pkgs.fetchFromGitHub {
      owner = "bblanchon"; repo = "ArduinoJson"; rev = "v7.4.0"; sha256 = lib.fakeSha256;
    };
    Async_TCP = pkgs.fetchFromGitHub {
      owner = "ESP32Async"; repo = "AsyncTCP"; rev = "3.4.4"; sha256 = lib.fakeSha256;
    };
    ESP_Async_TCP = pkgs.fetchFromGitHub {
      owner = "ESP32Async"; repo = "ESPAsyncTCP"; rev = "2.0.0"; sha256 = lib.fakeSha256;
    };
    ESP_Async_WebServer = pkgs.fetchFromGitHub {
      owner = "ESP32Async"; repo = "ESPAsyncWebServer"; rev = "3.7.10"; sha256 = lib.fakeSha256;
    };
    LoRa = pkgs.fetchFromGitHub {
      owner = "sandeepmistry"; repo = "arduino-LoRa"; rev = "master"; sha256 = lib.fakeSha256;
    };
    SolarCalculator = pkgs.fetchFromGitHub {
      owner = "jpb10"; repo = "SolarCalculator"; rev = "v1.0.3"; sha256 = lib.fakeSha256;
    };
    SparkFun_Extensible_Message_Parser = pkgs.fetchFromGitHub {
      owner = "sparkfun"; repo = "SparkFun_Extensible_Message_Parser"; rev = "v1.0.3"; sha256 = lib.fakeSha256;
    };
    SparkFun_u_blox_GNSS_Arduino_Library = pkgs.fetchFromGitHub {
      owner = "sparkfun"; repo = "SparkFun_u-blox_GNSS_Arduino_Library"; rev = "v2.2.28"; sha256 = lib.fakeSha256;
    };
    U8g2 = pkgs.fetchFromGitHub {
      owner = "olikraus"; repo = "U8g2_Arduino"; rev = "2.35.30"; sha256 = lib.fakeSha256;
    };
    XPowersLib = pkgs.fetchFromGitHub {
      owner = "lewisxhe"; repo = "XPowersLib"; rev = "v0.2.5"; sha256 = lib.fakeSha256;
    };
  };
in
{
  xdg.enable = true;

  xdg.configFile."arduino-cli.yaml".text = ''
    board_manager:
      additional_urls: []
    directories:
      data: ${config.xdg.dataHome}/arduino15
      downloads: ${config.xdg.cacheHome}/arduino
      user: ${config.home.homeDirectory}/Arduino
  '';

  home.file."Arduino/libraries/Adafruit_BME280_Library".source = arduinoLibs.Adafruit_BME280_Library;
  home.file."Arduino/libraries/Adafruit_BusIO".source = arduinoLibs.Adafruit_BusIO;
  home.file."Arduino/libraries/Adafruit_GFX_Library".source = arduinoLibs.Adafruit_GFX_Library;
  home.file."Arduino/libraries/Adafruit_SSD1306".source = arduinoLibs.Adafruit_SSD1306;
  home.file."Arduino/libraries/Adafruit_Unified_Sensor".source = arduinoLibs.Adafruit_Unified_Sensor;
  home.file."Arduino/libraries/Adafruit_XCA9554".source = arduinoLibs.Adafruit_XCA9554;
  home.file."Arduino/libraries/Arduino_JSON".source = arduinoLibs.Arduino_JSON;
  home.file."Arduino/libraries/ArduinoJson".source = arduinoLibs.ArduinoJson;
  home.file."Arduino/libraries/Async_TCP".source = arduinoLibs.Async_TCP;
  home.file."Arduino/libraries/ESP_Async_TCP".source = arduinoLibs.ESP_Async_TCP;
  home.file."Arduino/libraries/ESP_Async_WebServer".source = arduinoLibs.ESP_Async_WebServer;
  home.file."Arduino/libraries/LoRa".source = arduinoLibs.LoRa;
  home.file."Arduino/libraries/SolarCalculator".source = arduinoLibs.SolarCalculator;
  home.file."Arduino/libraries/SparkFun_Extensible_Message_Parser".source = arduinoLibs.SparkFun_Extensible_Message_Parser;
  home.file."Arduino/libraries/SparkFun_u-blox_GNSS_Arduino_Library".source = arduinoLibs.SparkFun_u_blox_GNSS_Arduino_Library;
  home.file."Arduino/libraries/U8g2".source = arduinoLibs.U8g2;
  home.file."Arduino/libraries/XPowersLib".source = arduinoLibs.XPowersLib;
}
