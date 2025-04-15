///  https://emea.cockpit.btp.cloud.sap/cockpit/#/globalaccount	sandeepk@sturlite.com	Welcome#2024



//mainfest.yml
/// applications:
///   - name: inflowQA
///     buildpack: https://github.com/cloudfoundry/staticfile-buildpack


import 'dart:convert';

abstract class StaticData {
  /// QA system
  static String username = 'INTEGRATION';
  static String password = 'EagzmjoXYWHSKrrPFVvREPk6QvPovBNwl~plVbYv';
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  static String apiURL ='https://Sturliteapp-chipper-bear-vb.cfapps.in30.hana.ondemand.com/api/sap_odata_get/Customising';
  static String patchapiURL='https://Sturliteapp-chipper-bear-vb.cfapps.in30.hana.ondemand.com/api/sap_odata_patch/Customising';
  // /YY1_USERCRED_CDS/YY1_USERCRED/12786389742178

  static String orignalBatchNo ='816';
  static String channalPartName ='817';
  static String ovfNo ='818';

  /// Production System
  // static String username = 'INTEGRATION';
  // static String password = 'rXnDqEpDv2WlWYahKnEGo)mwREoCafQNorwoDpLl';
  // static String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  // static String apiURL ='https://inflowproduction-noisy-elephant-ss.cfapps.in30.hana.ondemand.com/api';
  // static String orignalBatchNo ='812';
  // static String channalPartName ='813';
  // static String ovfNo ='814';


}


Map<String, String> countryMappings = {
  "Andorra": "AD",
  "Utd.Arab Emir.": "AE",
  "Afghanistan": "AF",
  "Antigua/Barbuda": "AG",
  "Anguilla": "AI",
  "Albania": "AL",
  "Armenia": "AM",
  "Angola": "AO",
  "Antarctica": "AQ",
  "Argentina": "AR",
  "Samoa, America": "AS",
  "Austria": "AT",
  "Australia": "AU",
  "Aruba": "AW",
  "Aland Islands": "AX",
  "Azerbaijan": "AZ",
  "Bosnia-Herz.": "BA",
  "Barbados": "BB",
  "Bangladesh": "BD",
  "Belgium": "BE",
  "Burkina Faso": "BF",
  "Bulgaria": "BG",
  "Bahrain": "BH",
  "Burundi": "BI",
  "Benin": "BJ",
  "St Barthelemy": "BL",
  "Bermuda": "BM",
  "Brunei Daruss.": "BN",
  "Bolivia": "BO",
  "Bonaire, Saba": "BQ",
  "Brazil": "BR",
  "Bahamas": "BS",
  "Bhutan": "BT",
  "Bouvet Islands": "BV",
  "Botswana": "BW",
  "Belarus": "BY",
  "Belize": "BZ",
  "Canada": "CA",
  "Cocos Islands": "CC",
  "Dem. Rep. Congo": "CD",
  "CAR": "CF",
  "Rep.of Congo": "CG",
  "Switzerland": "CH",
  "Cote d'Ivoire": "CI",
  "Cook Islands": "CK",
  "Chile": "CL",
  "Cameroon": "CM",
  "China": "CN",
  "Colombia": "CO",
  "Costa Rica": "CR",
  "Cuba": "CU",
  "Cabo Verde": "CV",
  "Curaçao": "CW",
  "Christmas Islnd": "CX",
  "Cyprus": "CY",
  "Czech Republic": "CZ",
  "Germany": "DE",
  "Djibouti": "DJ",
  "Denmark": "DK",
  "Dominica": "DM",
  "Dominican Rep.": "DO",
  "Algeria": "DZ",
  "Ecuador": "EC",
  "Estonia": "EE",
  "Egypt": "EG",
  "West Sahara": "EH",
  "Eritrea": "ER",
  "Spain": "ES",
  "Ethiopia": "ET",
  "Finland": "FI",
  "Fiji": "FJ",
  "Falkland Islnds": "FK",
  "Micronesia": "FM",
  "Faroe Islands": "FO",
  "France": "FR",
  "Gabon": "GA",
  "United Kingdom": "GB",
  "Grenada": "GD",
  "Georgia": "GE",
  "French Guayana": "GF",
  "Guernsey": "GG",
  "Ghana": "GH",
  "Gibraltar": "GI",
  "Greenland": "GL",
  "Gambia": "GM",
  "Guinea": "GN",
  "Guadeloupe": "GP",
  "Equatorial Guin": "GQ",
  "Greece": "GR",
  "S. Sandwich Ins": "GS",
  "Guatemala": "GT",
  "Guam": "GU",
  "Guinea-Bissau": "GW",
  "Guyana": "GY",
  "Hong Kong": "HK",
  "Heard/McDon.Isl": "HM",
  "Honduras": "HN",
  "Croatia": "HR",
  "Haiti": "HT",
  "Hungary": "HU",
  "Indonesia": "ID",
  "Ireland": "IE",
  "Israel": "IL",
  "Isle of Man": "IM",
  "India": "IN",
  "Brit.Ind.Oc.Ter": "IO",
  "Iraq": "IQ",
  "Iran": "IR",
  "Iceland": "IS",
  "Italy": "IT",
  "Jersey": "JE",
  "Jamaica": "JM",
  "Jordan": "JO",
  "Japan": "JP",
  "Kenya": "KE",
  "Kyrgyzstan": "KG",
  "Cambodia": "KH",
  "Kiribati": "KI",
  "Comoros": "KM",
  "St Kitts&Nevis": "KN",
  "North Korea": "KP",
  "South Korea": "KR",
  "Kuwait": "KW",
  "Cayman Islands": "KY",
  "Kazakhstan": "KZ",
  "Laos": "LA",
  "Lebanon": "LB",
  "St. Lucia": "LC",
  "Liechtenstein": "LI",
  "Sri Lanka": "LK",
  "Liberia": "LR",
  "Lesotho": "LS",
  "Lithuania": "LT",
  "Luxembourg": "LU",
  "Latvia": "LV",
  "Libya": "LY",
  "Morocco": "MA",
  "Monaco": "MC",
  "Moldova": "MD",
  "Montenegro": "ME",
  "Saint Martin": "MF",
  "Madagascar": "MG",
  "Marshall Islnds": "MH",
  "North Macedonia": "MK",
  "Mali": "ML",
  "Myanmar": "MM",
  "Mongolia": "MN",
  "Macao": "MO",
  "N.Mariana Islnd": "MP",
  "Martinique": "MQ",
  "Mauretania": "MR",
  "Montserrat": "MS",
  "Malta": "MT",
  "Mauritius": "MU",
  "Maldives": "MV",
  "Malawi": "MW",
  "Mexico": "MX",
  "Malaysia": "MY",
  "Mozambique": "MZ",
  "Namibia": "NA",
  "New Caledonia": "NC",
  "Niger": "NE",
  "Norfolk Islands": "NF",
  "Nigeria": "NG",
  "Nicaragua": "NI",
  "Netherlands": "NL",
  "Norway": "NO",
  "Nepal": "NP",
  "Nauru": "NR",
  "Niue": "NU",
  "New Zealand": "NZ",
  "Oman": "OM",
  "Panama": "PA",
  "Peru": "PE",
  "Frenc.Polynesia": "PF",
  "Pap. New Guinea": "PG",
  "Philippines": "PH",
  "Pakistan": "PK",
  "Poland": "PL",
  "St.Pier,Miquel.": "PM",
  "Pitcairn Islnds": "PN",
  "Puerto Rico": "PR",
  "Palestine": "PS",
  "Portugal": "PT",
  "Palau": "PW",
  "Paraguay": "PY",
  "Qatar": "QA",
  "Reunion": "RE",
  "Romania": "RO",
  "Serbia": "RS",
  "Russian Fed.": "RU",
  "Rwanda": "RW",
  "Saudi Arabia": "SA",
  "Solomon Islands": "SB",
  "Seychelles": "SC",
  "Sudan": "SD",
  "Sweden": "SE",
  "Singapore": "SG",
  "Saint Helena": "SH",
  "Slovenia": "SI",
  "Svalbard": "SJ",
  "Slovakia": "SK",
  "Sierra Leone": "SL",
  "San Marino": "SM",
  "Senegal": "SN",
  "Somalia": "SO",
  "Suriname": "SR",
  "South Sudan": "SS",
  "S.Tome,Principe": "ST",
  "El Salvador": "SV",
  "Sint Maarten": "SX",
  "Syria": "SY",
  "Eswatini": "SZ",
  "Turksh Caicosin": "TC",
  "Chad": "TD",
  "French S.Territ": "TF",
  "Togo": "TG",
  "Thailand": "TH",
  "Tajikistan": "TJ",
  "Tokelau Islands": "TK",
  "Timor-Leste": "TL",
  "Turkmenistan": "TM",
  "Tunisia": "TN",
  "Tonga": "TO",
  "Türkiye": "TR",
  "Trinidad,Tobago": "TT",
  "Tuvalu": "TV",
  "Taiwan": "TW",
  "Tanzania": "TZ",
  "Ukraine": "UA",
  "Uganda": "UG",
  "Minor Outl.Isl.": "UM",
  "USA": "US",
  "Uruguay": "UY",
  "Uzbekistan": "UZ",
  "Vatican City": "VA",
  "St. Vincent": "VC",
  "Venezuela": "VE",
  "Brit.Virgin Is.": "VG",
  "Amer.Virgin Is.": "VI",
  "Vietnam": "VN",
  "Vanuatu": "VU",
  "Wallis,Futuna": "WF",
  "Samoa": "WS",
  "Yemen": "YE",
  "Mayotte": "YT",
  "South Africa": "ZA",
  "Zambia": "ZM",
  "Zimbabwe": "ZW",
};

Map<String, String> reversedCountryMappings = {
  "AD": "Andorra",
  "AE": "Utd.Arab Emir.",
  "AF": "Afghanistan",
  "AG": "Antigua/Barbuda",
  "AI": "Anguilla",
  "AL": "Albania",
  "AM": "Armenia",
  "AO": "Angola",
  "AQ": "Antarctica",
  "AR": "Argentina",
  "AS": "Samoa, America",
  "AT": "Austria",
  "AU": "Australia",
  "AW": "Aruba",
  "AX": "Aland Islands",
  "AZ": "Azerbaijan",
  "BA": "Bosnia-Herz.",
  "BB": "Barbados",
  "BD": "Bangladesh",
  "BE": "Belgium",
  "BF": "Burkina Faso",
  "BG": "Bulgaria",
  "BH": "Bahrain",
  "BI": "Burundi",
  "BJ": "Benin",
  "BL": "St Barthelemy",
  "BM": "Bermuda",
  "BN": "Brunei Daruss.",
  "BO": "Bolivia",
  "BQ": "Bonaire, Saba",
  "BR": "Brazil",
  "BS": "Bahamas",
  "BT": "Bhutan",
  "BV": "Bouvet Islands",
  "BW": "Botswana",
  "BY": "Belarus",
  "BZ": "Belize",
  "CA": "Canada",
  "CC": "Cocos Islands",
  "CD": "Dem. Rep. Congo",
  "CF": "CAR",
  "CG": "Rep.of Congo",
  "CH": "Switzerland",
  "CI": "Cote d'Ivoire",
  "CK": "Cook Islands",
  "CL": "Chile",
  "CM": "Cameroon",
  "CN": "China",
  "CO": "Colombia",
  "CR": "Costa Rica",
  "CU": "Cuba",
  "CV": "Cabo Verde",
  "CW": "Curaçao",
  "CX": "Christmas Islnd",
  "CY": "Cyprus",
  "CZ": "Czech Republic",
  "DE": "Germany",
  "DJ": "Djibouti",
  "DK": "Denmark",
  "DM": "Dominica",
  "DO": "Dominican Rep.",
  "DZ": "Algeria",
  "EC": "Ecuador",
  "EE": "Estonia",
  "EG": "Egypt",
  "EH": "West Sahara",
  "ER": "Eritrea",
  "ES": "Spain",
  "ET": "Ethiopia",
  "FI": "Finland",
  "FJ": "Fiji",
  "FK": "Falkland Islnds",
  "FM": "Micronesia",
  "FO": "Faroe Islands",
  "FR": "France",
  "GA": "Gabon",
  "GB": "United Kingdom",
  "GD": "Grenada",
  "GE": "Georgia",
  "GF": "French Guayana",
  "GG": "Guernsey",
  "GH": "Ghana",
  "GI": "Gibraltar",
  "GL": "Greenland",
  "GM": "Gambia",
  "GN": "Guinea",
  "GP": "Guadeloupe",
  "GQ": "Equatorial Guin",
  "GR": "Greece",
  "GS": "S. Sandwich Ins",
  "GT": "Guatemala",
  "GU": "Guam",
  "GW": "Guinea-Bissau",
  "GY": "Guyana",
  "HK": "Hong Kong",
  "HM": "Heard/McDon.Isl",
  "HN": "Honduras",
  "HR": "Croatia",
  "HT": "Haiti",
  "HU": "Hungary",
  "ID": "Indonesia",
  "IE": "Ireland",
  "IL": "Israel",
  "IM": "Isle of Man",
  "IN": "India",
  "IO": "Brit.Ind.Oc.Ter",
  "IQ": "Iraq",
  "IR": "Iran",
  "IS": "Iceland",
  "IT": "Italy",
  "JE": "Jersey",
  "JM": "Jamaica",
  "JO": "Jordan",
  "JP": "Japan",
  "KE": "Kenya",
  "KG": "Kyrgyzstan",
  "KH": "Cambodia",
  "KI": "Kiribati",
  "KM": "Comoros",
  "KN": "St Kitts&Nevis",
  "KP": "North Korea",
  "KR": "South Korea",
  "KW": "Kuwait",
  "KY": "Cayman Islands",
  "KZ": "Kazakhstan",
  "LA": "Laos",
  "LB": "Lebanon",
  "LC": "St. Lucia",
  "LI": "Liechtenstein",
  "LK": "Sri Lanka",
  "LR": "Liberia",
  "LS": "Lesotho",
  "LT": "Lithuania",
  "LU": "Luxembourg",
  "LV": "Latvia",
  "LY": "Libya",
  "MA": "Morocco",
  "MC": "Monaco",
  "MD": "Moldova",
  "ME": "Montenegro",
  "MF": "Saint Martin",
  "MG": "Madagascar",
  "MH": "Marshall Islnds",
  "MK": "North Macedonia",
  "ML": "Mali",
  "MM": "Myanmar",
  "MN": "Mongolia",
  "MO": "Macao",
  "MP": "N.Mariana Islnd",
  "MQ": "Martinique",
  "MR": "Mauretania",
  "MS": "Montserrat",
  "MT": "Malta",
  "MU": "Mauritius",
  "MV": "Maldives",
  "MW": "Malawi",
  "MX": "Mexico",
  "MY": "Malaysia",
  "MZ": "Mozambique",
  "NA": "Namibia",
  "NC": "New Caledonia",
  "NE": "Niger",
  "NF": "Norfolk Islands",
  "NG": "Nigeria",
  "NI": "Nicaragua",
  "NL": "Netherlands",
  "NO": "Norway",
  "NP": "Nepal",
  "NR": "Nauru",
  "NU": "Niue",
  "NZ": "New Zealand",
  "OM": "Oman",
  "PA": "Panama",
  "PE": "Peru",
  "PF": "Frenc.Polynesia",
  "PG": "Pap. New Guinea",
  "PH": "Philippines",
  "PK": "Pakistan",
  "PL": "Poland",
  "PM": "St.Pier,Miquel.",
  "PN": "Pitcairn Islnds",
  "PR": "Puerto Rico",
  "PS": "Palestine",
  "PT": "Portugal",
  "PW": "Palau",
  "PY": "Paraguay",
  "QA": "Qatar",
  "RE": "Reunion",
  "RO": "Romania",
  "RS": "Serbia",
  "RU": "Russian Fed.",
  "RW": "Rwanda",
  "SA": "Saudi Arabia",
  "SB": "Solomon Islands",
  "SC": "Seychelles",
  "SD": "Sudan",
  "SE": "Sweden",
  "SG": "Singapore",
  "SH": "Saint Helena",
  "SI": "Slovenia",
  "SJ": "Svalbard",
  "SK": "Slovakia",
  "SL": "Sierra Leone",
  "SM": "San Marino",
  "SN": "Senegal",
  "SO": "Somalia",
  "SR": "Suriname",
  "SS": "South Sudan",
  "ST": "S.Tome,Principe",
  "SV": "El Salvador",
  "SX": "Sint Maarten",
  "SY": "Syria",
  "SZ": "Eswatini",
  "TC": "Turksh Caicosin",
  "TD": "Chad",
  "TF": "French S.Territ",
  "TG": "Togo",
  "TH": "Thailand",
  "TJ": "Tajikistan",
  "TK": "Tokelau Islands",
  "TL": "Timor-Leste",
  "TM": "Turkmenistan",
  "TN": "Tunisia",
  "TO": "Tonga",
  "TR": "Türkiye",
  "TT": "Trinidad,Tobago",
  "TV": "Tuvalu",
  "TW": "Taiwan",
  "TZ": "Tanzania",
  "UA": "Ukraine",
  "UG": "Uganda",
  "UM": "Minor Outl.Isl.",
  "US": "USA",
  "UY": "Uruguay",
  "UZ": "Uzbekistan",
  "VA": "Vatican City",
  "VC": "St. Vincent",
  "VE": "Venezuela",
  "VG": "Brit.Virgin Is.",
  "VI": "Amer.Virgin Is.",
  "VN": "Vietnam",
  "VU": "Vanuatu",
  "WF": "Wallis,Futuna",
  "WS": "Samoa",
  "YE": "Yemen",
  "YT": "Mayotte",
  "ZA": "South Africa",
  "ZM": "Zambia",
  "ZW": "Zimbabwe",
};
List<String> plantList=[
'SE14',
'SE31',
'SE21',
'SE09',
'SE20',
'SE22',
'SE08',
'SE07',
'SE28',
'SE05',
'SE25',
'SE19',
'SE10',
'SE11',
'SE13',
'SE16',
'SE17',
'SE03',
'SE04',
'SE12',
'SE01',
'SE23',
'SE02',
'SE24',
'SE26',
];

// List<String> businessPlan=[
//   '3700',
//   '3700',
//   '2200',
//   '2400',
//   '2000',
//   '2300',
//   '2700',
//   '2700',
//   '2700',
//   '2700',
//   '2100',
//   '800',
//   '3300',
//   '3300',
//   '3300',
//   '3600',
//   '1900',
//   '2900',
//   '2900',
//   '100',
//   '2900',
//   '900',
//   '2900',
//   '1800',
//   '1000',
//
// ];
List<Map<String, String>> businessPlan = [
{"code": "3700", "name": "Sturlite -ONE TOWN(VIJAYAWADA)"},
{"code": "3700", "name": "Sturlite -ONE TOWN(VIJAYAWADA)"},
{"code": "2200", "name": "Sturlite - RAIPUR"},
{"code": "2400", "name": "Sturlite - Ahmedabad"},
{"code": "2000", "name": "Sturlite - Ranchi"},
{"code": "2300", "name": "Sturlite - BHOPAL"},
{"code": "2700", "name": "Sturlite -Sturlite - BUDHAWARPETH"},
{"code": "2700", "name": "Sturlite -Sturlite - BUDHAWARPETH"},
{"code": "2700", "name": "Sturlite -Sturlite - BUDHAWARPETH"},
{"code": "2100", "name": "Sturlite -Sturlite - BUDHAWARPETH"},
{"code": "2100", "name": "Sturlite - CUTTACK"},
{"code": "800", "name": "Sturlite - JAIPUR"},
{"code": "3300", "name": "Sturlite - Chennai"},
{"code": "3300", "name": "Sturlite - Chennai"},
{"code": "3300", "name": "Sturlite - Chennai"},
{"code": "3600", "name": "Sturlite - HYDERABAD"},
{"code": "1900", "name": "Sturlite - KOLKATA"},
{"code": "2900", "name": "Sturlite  - Mysore Road"},
{"code": "2900", "name": "Sturlite  - Mysore Road"},
{"code": "100", "name": "Sturlite-Srinagar"},
{"code": "2900", "name": "Sturlite  - Mysore Road"},
{"code": "900", "name": "Sturlite - LUCKNOW"},
{"code": "2900", "name": "Sturlite  - Mysore Road"},
{"code": "1800", "name": "Sturlite - GUWAHATI"},
{"code": "1000", "name": "Sturlite - PATNA"},

];

List<String> endCustomerStateRGItems = [
  'AndraPradesh',
  'ArunachalPradesh',
  'Assam',
  'Bihar',
  'Chandigarh',
  'Chhaattisgarh',
  'Obsolete',
  'DadraNagHavDamanDiu',
  'Delhi',
  'Goa',
  'Gujarat',
  'HimachalPradesh',
  'Haryana',
  'Jharkhand',
  'JammuandKashmir',
  'Karnataka',
  'Kerala',
  'Ladakh',
  'Lakshadweep',
  'Maharashtra',
  'Megalaya',
  'Manipur',
  'MadhyaPradesh',
  'Mizoram',
  'Nagaland',
  'Orissa',
  'Punjab',
  'Pondicherry',
  'Rajasthan',
  'Sikkim',
  'Telangana',
  'TamilNadu',
  'Tripura',
  'UttarPradesh',
  'Uttarakhand',
  'WestBengal',
];


List<String> endCustomerStateCNItems = [
  "Andorra",
  "Utd.Arab Emir.",
  "Afghanistan",
  "Antigua/Barbuda",
  "Anguilla",
  "Albania",
  "Armenia",
  "Angola",
  "Antarctica",
  "Argentina",
  "Samoa, America",
  "Austria",
  "Australia",
  "Aruba",
  "Aland Islands",
  "Azerbaijan",
  "Bosnia-Herz.",
  "Barbados",
  "Bangladesh",
  "Belgium",
  "Burkina Faso",
  "Bulgaria",
  "Bahrain",
  "Burundi",
  "Benin",
  "St Barthelemy",
  "Bermuda",
  "Brunei Daruss.",
  "Bolivia",
  "Bonaire, Saba",
  "Brazil",
  "Bahamas",
  "Bhutan",
  "Bouvet Islands",
  "Botswana",
  "Belarus",
  "Belize",
  "Canada",
  "Cocos Islands",
  "Dem. Rep. Congo",
  "CAR",
  "Rep.of Congo",
  "Switzerland",
  "Cote d'Ivoire",
  "Cook Islands",
  "Chile",
  "Cameroon",
  "China",
  "Colombia",
  "Costa Rica",
  "Cuba",
  "Cabo Verde",
  "CuraÃ§ao",
  "Christmas Islnd",
  "Cyprus",
  "Czech Republic",
  "Germany",
  "Djibouti",
  "Denmark",
  "Dominica",
  "Dominican Rep.",
  "Algeria",
  "Ecuador",
  "Estonia",
  "Egypt",
  "West Sahara",
  "Eritrea",
  "Spain",
  "Ethiopia",
  "Finland",
  "Fiji",
  "Falkland Islnds",
  "Micronesia",
  "Faroe Islands",
  "France",
  "Gabon",
  "United Kingdom",
  "Grenada",
  "Georgia",
  "French Guayana",
  "Guernsey",
  "Ghana",
  "Gibraltar",
  "Greenland",
  "Gambia",
  "Guinea",
  "Guadeloupe",
  "Equatorial Guin",
  "Greece",
  "S. Sandwich Ins",
  "Guatemala",
  "Guam",
  "Guinea-Bissau",
  "Guyana",
  "Hong Kong",
  "Heard/McDon.Isl",
  "Honduras",
  "Croatia",
  "Haiti",
  "Hungary",
  "Indonesia",
  "Ireland",
  "Israel",
  "Isle of Man",
  "India",
  "Brit.Ind.Oc.Ter",
  "Iraq",
  "Iran",
  "Iceland",
  "Italy",
  "Jersey",
  "Jamaica",
  "Jordan",
  "Japan",
  "Kenya",
  "Kyrgyzstan",
  "Cambodia",
  "Kiribati",
  "Comoros",
  "St Kitts&Nevis",
  "North Korea",
  "South Korea",
  "Kuwait",
  "Cayman Islands",
  "Kazakhstan",
  "Laos",
  "Lebanon",
  "St. Lucia",
  "Liechtenstein",
  "Sri Lanka",
  "Liberia",
  "Lesotho",
  "Lithuania",
  "Luxembourg",
  "Latvia",
  "Libya",
  "Morocco",
  "Monaco",
  "Moldova",
  "Montenegro",
  "Saint Martin",
  "Madagascar",
  "Marshall Islnds",
  "North Macedonia",
  "Mali",
  "Myanmar",
  "Mongolia",
  "Macao",
  "N.Mariana Islnd",
  "Martinique",
  "Mauretania",
  "Montserrat",
  "Malta",
  "Mauritius",
  "Maldives",
  "Malawi",
  "Mexico",
  "Malaysia",
  "Mozambique",
  "Namibia",
  "New Caledonia",
  "Niger",
  "Norfolk Islands",
  "Nigeria",
  "Nicaragua",
  "Netherlands",
  "Norway",
  "Nepal",
  "Nauru",
  "Niue",
  "New Zealand",
  "Oman",
  "Panama",
  "Peru",
  "Frenc.Polynesia",
  "Pap. New Guinea",
  "Philippines",
  "Pakistan",
  "Poland",
  "St.Pier,Miquel.",
  "Pitcairn Islnds",
  "Puerto Rico",
  "Palestine",
  "Portugal",
  "Palau",
  "Paraguay",
  "Qatar",
  "Reunion",
  "Romania",
  "Serbia",
  "Russian Fed.",
  "Rwanda",
  "Saudi Arabia",
  "Solomon Islands",
  "Seychelles",
  "Sudan",
  "Sweden",
  "Singapore",
  "Saint Helena",
  "Slovenia",
  "Svalbard",
  "Slovakia",
  "Sierra Leone",
  "San Marino",
  "Senegal",
  "Somalia",
  "Suriname",
  "South Sudan",
  "S.Tome,Principe",
  "El Salvador",
  "Sint Maarten",
  "Syria",
  "Eswatini",
  "Turksh Caicosin",
  "Chad",
  "French S.Territ",
  "Togo",
  "Thailand",
  "Tajikistan",
  "Tokelau Islands",
  "Timor-Leste",
  "Turkmenistan",
  "Tunisia",
  "Tonga",
  "TÃ¼rkiye",
  "Trinidad,Tobago",
  "Tuvalu",
  "Taiwan",
  "Tanzania",
  "Ukraine",
  "Uganda",
  "Minor Outl.Isl.",
  "USA",
  "Uruguay",
  "Uzbekistan",
  "Vatican City",
  "St. Vincent",
  "Venezuela",
  "Brit.Virgin Is.",
  "Amer.Virgin Is.",
  "Vietnam",
  "Vanuatu",
  "Wallis,Futuna",
  "Samoa",
  "Yemen",
  "Mayotte",
  "South Africa",
  "Zambia",
  "Zimbabwe",
];


List<String> outstandingItems = [
  "Ahmedabad",
  "Bangalore",
  "Bhubaneshwar",
  "Bangladesh",
  "Bhutan",
  "Chandigargh",
  "Chennai",
  "Cochin",
  "Corporate",
  "Dehradum",
  "Delhi",
  "Dhaka",
  "Gurgahon",
  "Guwahati",
  "Hyderabad",
  "Indore",
  "Jaipur",
  "Kathmandu",
  "Kolkata",
  "Lucknow",
  "Mumbai",
  "Nepal",
  "Pune",
  "Strategic Accounts 1",
  "Strategic Accounts 2",
  "Services Direct",
  "Singapore",
  "Srilanka"
];
Map<String, String> stateMappings = {
  "AndraPradesh": "AP",
  "ArunachalPradesh": "AR",
  "Assam": "AS",
  "Bihar": "BR",
  "Chandigarh": "CH",
  "Chhaattisgarh": "CT",
  "Obsolete": "DD",
  "DadraNagHavDamanDiu": "DH",
  "Delhi": "DL",
  "Goa": "GA",
  "Gujarat": "GJ",
  "HimachalPradesh": "HP",
  "Haryana": "HR",
  "Jharkhand": "JH",
  "JammuandKashmir": "JK",
  "Karnataka": "KA",
  "Kerala": "KL",
  "Ladakh": "LA",
  "Lakshadweep": "LD",
  "Maharashtra": "MH",
  "Megalaya": "ML",
  "Manipur": "MN",
  "MadhyaPradesh": "MP",
  "Mizoram": "MZ",
  "Nagaland": "NL",
  "Orissa": "OR",
  "Punjab": "PB",
  "Pondicherry": "PY",
  "Rajasthan": "RJ",
  "Sikkim": "SK",
  "Telangana": "TG",
  "TamilNadu": "TN",
  "Tripura": "TR",
  "UttarPradesh": "UP",
  "Uttarakhand": "UT",
  "WestBengal": "WB",
};

Map<String, String> reversedStateMappings = {
  "AP": "AndraPradesh",
  "AR": "ArunachalPradesh",
  "AS": "Assam",
  "BR": "Bihar",
  "CH": "Chandigarh",
  "CT": "Chhaattisgarh",
  "DD": "Obsolete",
  "DH": "DadraNagHavDamanDiu",
  "DL": "Delhi",
  "GA": "Goa",
  "GJ": "Gujarat",
  "HP": "HimachalPradesh",
  "HR": "Haryana",
  "JH": "Jharkhand",
  "JK": "JammuandKashmir",
  "KA": "Karnataka",
  "KL": "Kerala",
  "LA": "Ladakh",
  "LD": "Lakshadweep",
  "MH": "Maharashtra",
  "ML": "Megalaya",
  "MN": "Manipur",
  "MP": "MadhyaPradesh",
  "MZ": "Mizoram",
  "NL": "Nagaland",
  "OR": "Orissa",
  "PB": "Punjab",
  "PY": "Pondicherry",
  "RJ": "Rajasthan",
  "SK": "Sikkim",
  "TG": "Telangana",
  "TN": "TamilNadu",
  "TR": "Tripura",
  "UP": "UttarPradesh",
  "UT": "Uttarakhand",
  "WB": "WestBengal",
};


Map<String, String> priceTypeMap = {
  "PE Awaited": "101",
  "Disti Promo": "102",
  "D1 Price": "103",
  "Demo Price": "104",
  "PE Price": "105",
};

Map<String, String> shipmentStatusMap = {
  "PO Not placed on Vendor - HO": "1",
  "PO Not placed on Vendor-Region": "2",
  "Order Logged - Shpt Awaited": "3",
  "Order Not Processed on Vendor, pricing awaited": "4",
  "Order Not Processed on Vendor clarification awaited from reg": "5",
  "Order logged, shipment awaited from vendor": "6",
  "Partner account on hold - contact credit controller": "7",
  "Shipment billed from vendor but not handed over to our FF": "8",
  "Document amendment required from Vendor": "9",
  "picked up from vendor, awaiting booking details": "10",
  "Shipment In Transit from Vendor to Chennai": "11",
  "Shipment under Customs clearance": "12",
  "Shipment Under Bonding": "13",
  "Shipment under customs query - contact logistics team": "14",
  "License/Support key awaited": "15",
  "Inwarded and Material reached Central Warehouse": "16",
  "Material in transit to region": "17",
  "Material ready for billing, CP/EC on credit hold": "18",
  "Material ready for billing, awaiting clarification from reg": "19",
  "Billed": "20",
  "Short/Wrong Shipment recd from Vendor-Contact Logistics Team": "21",
  "Partially Billed, balance shipment awaited from TP": "22",
  "Partial shipment in Transit": "23",
  "Service delivery not completed": "24",
  "License awaited along with HW processed": "25",
  "Periodic Billing": "26",
  "Partial Shipment Available, Balance Awatied From TP": "27",
  "Partially Billed from Stock, Balance Awaited from TP": "28",
  "Shipment debonding under process": "29",
  "Planned Ship Date Received from Vendor for entire order": "30",
  "Order processed on Vendor with Condition": "31",
  "Stock and License Available, Support awaited": "32",
  "Shipment under consolidation at origin": "33",
  "Billing from Stock": "34",
  "PE Awaited": "35",
  "Order Value below \$1000-Moto E": "36",
  "Local Purchase-Awaiting Shipment from vendor": "37",
  "Local Purchase-Picked Up and will be billed": "38",
  "Partial Shpt Ready with Vendor, balance on later date": "39",
  "Stock Order Loaded yet to get shipment": "40",
  "SLA to be provided by Region": "41",
  "Support Contract Available, Region to Confirm on Billing": "42",
  "Deal ID-NSP-SPR Awaited from BDM/PM": "43",
  "Need to Load Once H/W Billed": "44",
  "Quote/Order discrepancy": "45",
  "Local Purchase - Material Reached Warehouse": "46",
  "Low margin, Approval awaited": "47",
  "Battery shipment on hold": "48",
  "Partial Loaded": "49",
  "Plan Shipment Date received from Domestic Vendor": "50",
  "Negative Deal approval awaited": "51",
  "Order not processed on Ops tea": "52",
  "RMA Invoice awaited from vendo": "53",
  "License received , Billing confirmation awaited from region": "54",
  "Less Order Value to load on ve": "55",
  "Order is on HOLD": "56",
  "TP / Price awaiting": "57",
  "Revised Partner PO Awaited": "58",
  "Awaiting flight connectivity": "59",
  "Advance order loaded awaiting shipment": "60",
  "Serial no awaited from partner": "61",
  "HID-Programming Details awaiting": "62",
  "Need to get revised PO with the valid EU name as per PC": "63",
  "PO part code and PC part code is not matching": "64",
  "Need to get revised PC with the valid entity": "65",
  "Awaiting for Zebra approval to bill the material": "66",
  "There is no sufficient qty. in available PC": "67",
  "Order logged on D1 awaited for PC": "68",
  "SKU is not matching with the MOQ": "69",
  "EOL SKU": "70",
  "Need to place manual PO on Zebra": "71",
  "Complete EU name require to process the order (SW & SUPP)": "72",
  "Shipment Hold @ Sing w/h due to Chennai lock down": "73",
  "Partial Shipment reached Central Warehouse": "74",
  "Shipment In Transit from Vendor to Singapore": "75",
  "Repacking Shipment in Singapore": "76",
  "Shipment Invoiced by Singapore Team": "77",
  "CIF Shipment - HAWB Awaited": "78",
  "EX Works Shipment - POD awaited": "79",
  "Shipment from Singapore": "80",
  "Shipment Arrived in Singapore Warehouse": "81",
  "Shipment received at origin and under consolidation": "82",
  "EUS Submitted, XO Permit awaited from Singapore Customs": "83",
  "End User Statement pending for XO permit from region": "84",
  "Bill from stock": "85",
  "PE awaiting": "86",
  "Supp will be loaded once H/W Billed": "87",
  "Below 1000\$ need to club with Other Order": "88",
  "\$ Shipment arrived Penang Whse": "89",
  "Plan ship date recd from Zebra": "90",
  "Plan ship date recd from Axis": "91",
  "Plan ship date recd from ATI": "92",
  "Plan ship date recd from Aruba": "93",
  "Bill from Stock Order": "94",
  "Negative Deal Approvals Awaited": "95",
  "License recived, billing awaited": "96",
  "Advance order placed on vendor shipment awaited": "97",
  "TP Awaiting from Product Team": "98",
};

Map<String, String> transactionTypeMap = {
  "Back To Back":"B2B",
  "Stock and Sales":"SAS"
};

Map<String, String> billToAddressMap = {
  "Bangalore Head Office":"101",
  "Chennai Branch":"102",
  "Delhi Branch":"103",
  "Ahmedabad Branch":"104",
  "Mumbai Branch":"105",
  "Kolkata Branch":"106",
  "Pune Branch":"107",
  "Hyderabad Branch":"108"
};
Map<String, String> reverseBillToAddressMap = {
  "101":"Bangalore Head Office",
  "102":"Chennai Branch",
  "103":"Delhi Branch",
  "104":"Ahmedabad Branch",
  "105":"Mumbai Branch",
  "106":"Kolkata Branch",
  "107":"Pune Branch",
  "108":"Hyderabad Branch"
};

String getTransactionTypeValue(String displayData) {
  switch (displayData) {
    case "B2B":
      return "Back To Back";
    case "SAS":
      return "Stock and Sales";
    default:
      return "";
  }
}

Map<String, String> typesOfOrderMap = {
  "New":"101",
  "Renewal":"102",
  "Support":"103",
};

Map<String, String> reversedTypesOfOrderMap = {
  "101": "New",
  "102": "Renewal",
  "103": "Support",
};


Map<String, String> shipToContactMap = {
  "INFLOW BANGALORE-WC(INF-BANW)":"A",
  "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)":"B",
  "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)":"C",
  "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)":"D",
  "INFLOW DELHI-WH(INF-DELW)":"E",
  "INFLOW DELHI (WH)(INF-DEL-WH)":"F",
  "INFLOW KOLKATA(INF-KOL)":"G",
  "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)":"H",
};

Map<String, String> billToContactMap = {
  "INFLOW BANGALORE-WC(INF-BANW)":"A",
  "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)":"B",
  "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)":"C",
  "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)":"D",
  "INFLOW DELHI-WH(INF-DELW)":"E",
  "INFLOW DELHI (WH)(INF-DEL-WH)":"F",
  "INFLOW KOLKATA(INF-KOL)":"G",
  "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)":"H",
};

Map<String, String> reversedBillToContactMap = {
  "A": "INFLOW BANGALORE-WC(INF-BANW)",
  "B": "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)",
  "C": "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)",
  "D": "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)",
  "E": "INFLOW DELHI-WH(INF-DELW)",
  "F": "INFLOW DELHI (WH)(INF-DEL-WH)",
  "G": "INFLOW KOLKATA(INF-KOL)",
  "H": "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)"
};

Map<String, String> getBillToContactMapFromExcel = {
  "INF-BANW":"A",
  "INF-CHN6":"B",
  "INF-CHN-FTWZ":"C",
  "INF-DEL6":"D",
  "INF-DELW":"E",
  "INF-DEL-WH":"F",
  "INF-KOL":"G",
  "INF-KOL-WH":"H",
};

String getBillToContactMap(String contactCode) {
  switch (contactCode) {
    case "A":
      return "INFLOW BANGALORE-WC(INF-BANW)";
    case "B":
      return "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)";
    case "C":
      return "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)";
    case "D":
      return "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)";
    case "E":
      return "INFLOW DELHI-WH(INF-DELW)";
    case "F":
      return "INFLOW DELHI (WH)(INF-DEL-WH)";
    case "G":
      return "INFLOW KOLKATA(INF-KOL)";
    case "H":
      return "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)";
    default:
      return "";
  }
}

Map<String, String> ocbMap = {
  "Ahmedabad": "AHM",
  "Bangalore": "BAN",
  "Bhubaneshwar": "BBR",
  "Bangladesh": "BGL",
  "Bhutan": "BHU",
  "Chandigargh": "CHA",
  "Chennai": "CHI",
  "Cochin": "COH",
  "Corporate": "COR",
  "Dehradum": "DED",
  "Delhi": "DEL",
  "Dhaka": "DHA",
  "Gurgahon": "GUR",
  "Guwahati": "GUW",
  "Hyderabad": "HYD",
  "Indore": "IND",
  "Jaipur": "JAI",
  "Kathmandu": "KAT",
  "Kolkata": "KOL",
  "Lucknow": "LKO",
  "Mumbai": "MUM",
  "Nepal": "NEP",
  "Pune": "PUN",
  "Strategic Accounts 1": "SA1",
  "Strategic Accounts 2": "SA2",
  "Services Direct": "SER",
  "Singapore": "SNG",
  "Srilanka": "SRI",
};

var billToAddressItems = [
  "Bangalore Head Office",
  "Chennai Branch",
  "Delhi Branch",
  "Ahmedabad Branch",
  "Mumbai Branch",
  "Kolkata Branch",
  "Pune Branch",
  "Hyderabad Branch",
];

var shipToContactNameItems = [
  "INFLOW BANGALORE-WC(INF-BANW)",
  "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)",
  "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)",
  "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)",
  "INFLOW DELHI-WH(INF-DELW)",
  "INFLOW DELHI (WH)(INF-DEL-WH)",
  "INFLOW KOLKATA(INF-KOL)",
  "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)"
];
var billToContactNameItems = [
  "INFLOW BANGALORE-WC(INF-BANW)",
  "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)",
  "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)",
  "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)",
  "INFLOW DELHI-WH(INF-DELW)",
  "INFLOW DELHI (WH)(INF-DEL-WH)",
  "INFLOW KOLKATA(INF-KOL)",
  "INFLOW KOLKATA WAREHOUSE(INF-KOL-WH)"
];
var typesOfOrderItems = [
  "New",
  "Renewal",
  "Support",
];
var pePriceTypeItems=[
  "PE Awaited",
  "Disti Promo",
  "D1 Price",
  "Demo Price",
  "PE Price",
];
Map<String, String> reversePEPrice = {
  "101":"PE Awaited",
  "102":"Disti Promo",
  "103":"D1 Price",
  "104":"Demo Price",
  "105":"PE Price",
};
var transactionTypeItem = [
  "Back To Back",
  "Stock and Sales"
];
Map<String, String> reversedTransactionType = {
  "B2B": "Back To Back",
  "SAS": "Stock and Sales"
};
var shipmentStatusItem=[
  "PO Not placed on Vendor - HO",
  "PO Not placed on Vendor-Region",
  "Order Logged - Shpt Awaited",
  "Order Not Processed on Vendor, pricing awaited",
  "Order Not Processed on Vendor clarification awaited from reg",
  "Order logged, shipment awaited from vendor",
  "Partner account on hold - contact credit controller",
  "Shipment billed from vendor but not handed over to our FF",
  "Document amendment required from Vendor",
  "picked up from vendor, awaiting booking details",
  "Shipment In Transit from Vendor to Chennai",
  "Shipment under Customs clearance",
  "Shipment Under Bonding",
  "Shipment under customs query - contact logistics team",
  "License/Support key awaited",
  "Inwarded and Material reached Central Warehouse",
  "Material in transit to region",
  "Material ready for billing, CP/EC on credit hold",
  "Material ready for billing, awaiting clarification from reg",
  "Billed",
  "Short/Wrong Shipment recd from Vendor-Contact Logistics Team",
  "Partially Billed, balance shipment awaited from TP",
  "Partial shipment in Transit",
  "Service delivery not completed",
  "License awaited along with HW processed",
  "Periodic Billing",
  "Partial Shipment Available, Balance Awatied From TP",
  "Partially Billed from Stock, Balance Awaited from TP",
  "Shipment debonding under process",
  "Planned Ship Date Received from Vendor for entire order",
  "Order processed on Vendor with Condition",
  "Stock and License Available, Support awaited",
  "Shipment under consolidation at origin",
  "Billing from Stock",
  "PE Awaited",
  "Order Value below \$1000-Moto E",
  "Local Purchase-Awaiting Shipment from vendor",
  "Local Purchase-Picked Up and will be billed",
  "Partial Shpt Ready with Vendor, balance on later date",
  "Stock Order Loaded yet to get shipment",
  "SLA to be provided by Region",
  "Support Contract Available, Region to Confirm on Billing",
  "Deal ID-NSP-SPR Awaited from BDM/PM",
  "Need to Load Once H/W Billed",
  "Quote/Order discrepancy",
  "Local Purchase - Material Reached Warehouse",
  "Low margin, Approval awaited",
  "Battery shipment on hold",
  "Partial Loaded",
  "Plan Shipment Date received from Domestic Vendor",
  "Negative Deal approval awaited",
  "Order not processed on Ops tea",
  "RMA Invoice awaited from vendo",
  "License received , Billing confirmation awaited from region",
  "Less Order Value to load on ve",
  "Order is on HOLD",
  "TP / Price awaiting",
  "Revised Partner PO Awaited",
  "Awaiting flight connectivity",
  "Advance order loaded awaiting shipment",
  "Serial no awaited from partner",
  "HID-Programming Details awaiting",
  "Need to get revised PO with the valid EU name as per PC",
  "PO part code and PC part code is not matching",
  "Need to get revised PC with the valid entity",
  "Awaiting for Zebra approval to bill the material",
  "There is no sufficient qty. in available PC",
  "Order logged on D1 awaited for PC",
  "SKU is not matching with the MOQ",
  "EOL SKU",
  "Need to place manual PO on Zebra",
  "Complete EU name require to process the order (SW & SUPP)",
  "Shipment Hold @ Sing w/h due to Chennai lock down",
  "Partial Shipment reached Central Warehouse",
  "Shipment In Transit from Vendor to Singapore",
  "Repacking Shipment in Singapore",
  "Shipment Invoiced by Singapore Team",
  "CIF Shipment - HAWB Awaited",
  "EX Works Shipment - POD awaited",
  "Shipment from Singapore",
  "Shipment Arrived in Singapore Warehouse",
  "Shipment received at origin and under consolidation",
  "EUS Submitted, XO Permit awaited from Singapore Customs",
  "End User Statement pending for XO permit from region",
  "Bill from stock",
  "PE awaiting",
  "Supp will be loaded once H/W Billed",
  "Below 1000\$ need to club with Other Order",
  "\$ Shipment arrived Penang Whse",
  "Plan ship date recd from Zebra",
  "Plan ship date recd from Axis",
  "Plan ship date recd from ATI",
  "Plan ship date recd from Aruba",
  "Bill from Stock Order",
  "Negative Deal Approvals Awaited",
  "License recived, billing awaited",
  "Advance order placed on vendor shipment awaited",
  "TP Awaiting from Product Team",
];
Map<String, String> reverseShipmentStatus = {
  "1":"PO Not placed on Vendor - HO",
  "2":"PO Not placed on Vendor-Region",
  "3":"Order Logged - Shpt Awaited",
  "4": "Order Not Processed on Vendor, pricing awaited",
  "5": "Order Not Processed on Vendor clarification awaited from reg",
  "6": "Order logged, shipment awaited from vendor",
  "7": "Partner account on hold - contact credit controller",
  "8": "Shipment billed from vendor but not handed over to our FF",
  "9": "Document amendment required from Vendor",
  "10": "picked up from vendor, awaiting booking details",
  "11": "Shipment In Transit from Vendor to Chennai",
  "12": "Shipment under Customs clearance",
  "13": "Shipment Under Bonding",
  "14": "Shipment under customs query - contact logistics team",
  "15": "License/Support key awaited",
  "16": "Inwarded and Material reached Central Warehouse",
  "17": "Material in transit to region",
  "18": "Material ready for billing, CP/EC on credit hold",
  "19": "Material ready for billing, awaiting clarification from reg",
  "20": "Billed",
  "21": "Short/Wrong Shipment recd from Vendor-Contact Logistics Team",
  "22": "Partially Billed, balance shipment awaited from TP",
  "23": "Partial shipment in Transit",
  "24": "Service delivery not completed",
  "25": "License awaited along with HW processed",
  "26": "Periodic Billing",
  "27": "Partial Shipment Available, Balance Awatied From TP",
  "28": "Partially Billed from Stock, Balance Awaited from TP",
  "29": "Shipment debonding under process",
  "30": "Planned Ship Date Received from Vendor for entire order",
  "31": "Order processed on Vendor with Condition",
  "32": "Stock and License Available, Support awaited",
  "33": "Shipment under consolidation at origin",
  "34": "Billing from Stock",
  "35": "PE Awaited",
  "36": "Order Value below \$1000-Moto E",
  "37": "Local Purchase-Awaiting Shipment from vendor",
  "38": "Local Purchase-Picked Up and will be billed",
  "39": "Partial Shpt Ready with Vendor, balance on later date",
  "40": "Stock Order Loaded yet to get shipment",
  "41": "SLA to be provided by Region",
  "42": "Support Contract Available, Region to Confirm on Billing",
  "43": "Deal ID-NSP-SPR Awaited from BDM/PM",
  "44": "Need to Load Once H/W Billed",
  "45": "Quote/Order discrepancy",
  "46": "Local Purchase - Material Reached Warehouse",
  "47": "Low margin, Approval awaited",
  "48": "Battery shipment on hold",
  "49": "Partial Loaded",
  "50": "Plan Shipment Date received from Domestic Vendor",
  "51": "Negative Deal approval awaited",
  "52": "Order not processed on Ops tea",
  "53": "RMA Invoice awaited from vendo",
  "54": "License received , Billing confirmation awaited from region",
  "55": "Less Order Value to load on ve",
  "56": "Order is on HOLD",
  "57": "TP / Price awaiting",
  "58": "Revised Partner PO Awaited",
  "59": "Awaiting flight connectivity",
  "60": "Advance order loaded awaiting shipment",
  "61": "Serial no awaited from partner",
  "62": "HID-Programming Details awaiting",
  "63": "Need to get revised PO with the valid EU name as per PC",
  "64": "PO part code and PC part code is not matching",
  "65": "Need to get revised PC with the valid entity",
  "66": "Awaiting for Zebra approval to bill the material",
  "67": "There is no sufficient qty. in available PC",
  "68": "Order logged on D1 awaited for PC",
  "69": "SKU is not matching with the MOQ",
  "70": "EOL SKU",
  "71": "Need to place manual PO on Zebra",
  "72": "Complete EU name require to process the order (SW & SUPP)",
  "73": "Shipment Hold @ Sing w/h due to Chennai lock down",
  "74": "Partial Shipment reached Central Warehouse",
  "75": "Shipment In Transit from Vendor to Singapore",
  "76": "Repacking Shipment in Singapore",
  "77": "Shipment Invoiced by Singapore Team",
  "78": "CIF Shipment - HAWB Awaited",
  "79": "EX Works Shipment - POD awaited",
  "80": "Shipment from Singapore",
  "81": "Shipment Arrived in Singapore Warehouse",
  "82": "Shipment received at origin and under consolidation",
  "83": "EUS Submitted, XO Permit awaited from Singapore Customs",
  "84": "End User Statement pending for XO permit from region",
  "85": "Bill from stock",
  "86": "PE awaiting",
  "87": "Supp will be loaded once H/W Billed",
  "88": "Below 1000\$ need to club with Other Order",
  "89": "\$ Shipment arrived Penang Whse",
  "90": "Plan ship date recd from Zebra",
  "91": "Plan ship date recd from Axis",
  "92": "Plan ship date recd from ATI",
  "93": "Plan ship date recd from Aruba",
  "94": "Bill from Stock Order",
  "95": "Negative Deal Approvals Awaited",
  "96": "License recived, billing awaited",
  "97": "Advance order placed on vendor shipment awaited",
  "98": "TP Awaiting from Product Team",
};


Map<String, String> cityMappings = {
  "Ahmedabad": "AHM",
  "Bangalore": "BAN",
  "Bhubaneswar": "BBR",
  "Bangladesh": "BGL",
  "Bhutan": "BHU",
  "Chandigargh": "CHA",
  "Chennai": "CHI",
  "Cochin": "COH",
  "Corporate": "COR",
  "Dehradum": "DED",
  "Delhi": "DEL",
  "Dhaka": "DHA",
  "Gurgahon": "GUR",
  "Guwahati": "GUW",
  "Hyderabad": "HYD",
  "Indore": "IND",
  "Jaipur": "JAI",
  "Kathmandu": "KAT",
  "Kolkata": "KOL",
  "Lucknow": "LKO",
  "Mumbai": "MUM",
  "Nepal": "NEP",
  "Pune": "PUN",
  "Strategic Accounts 1": "SA1",
  "Strategic Accounts 2": "SA2",
  "Services Direct": "SER",
  "Singapore": "SNG",
  "Srilanka": "SRI",
};
Map<String, String> reversedCityMappings = {
  "AHM": "Ahmedabad",
  "BAN": "Bangalore",
  "BBR": "Bhubaneswar",
  "BGL": "Bangladesh",
  "BHU": "Bhutan",
  "CHA": "Chandigargh",
  "CHI": "Chennai",
  "COH": "Cochin",
  "COR": "Corporate",
  "DED": "Dehradum",
  "DEL": "Delhi",
  "DHA": "Dhaka",
  "GUR": "Gurgahon",
  "GUW": "Guwahati",
  "HYD": "Hyderabad",
  "IND": "Indore",
  "JAI": "Jaipur",
  "KAT": "Kathmandu",
  "KOL": "Kolkata",
  "LKO": "Lucknow",
  "MUM": "Mumbai",
  "NEP": "Nepal",
  "PUN": "Pune",
  "SA1": "Strategic Accounts 1",
  "SA2": "Strategic Accounts 2",
  "SER": "Services Direct",
  "SNG": "Singapore",
  "SRI": "Srilanka",
};


Map<String, String> shipToBillTo = {
  "INFLOW BANGALORE-WC(INF-BANW)": "A",
  "INFLOW TECHNOLOGIES PVT LTD(INF-CHN6)": "B",
  "INFLOW TECHNOLOGIES PRIVATE LIMITED(INF-CHN-FTWZ)": "C",
  "INFLOW DELHI-6 -( FOR STN)(INF-DEL6)": "D",
  "INFLOW DELHI-WH(INF-DELW)": "E",
  "INFLOW DELHI (WH)(INF-DEL-WH)": "F",
  "INFLOW KOLKATA(INF-KOL)": "G",
  "Inflow KOLKATA WAREHOUSE(INF-KOL-WH)": "H",
};

Map<String, String> typesOfOrderPDH = {
  "New": "101",
  "Renewal": "102",
  "Support": "103",
};


var cashJournalList = [
  "--Select--",
  "10020001",
  "10020501",
  "10020502",
  "10020503",
  "10020504",
  "10020505",
  "10020506",
  "10020507",
  "10020508",
  "10020509",
  "10020510",
  "10020511",
  "10020512",
  "10020513",
  "10020514",
  "10020515",
  "10020516",
  "10020517",
  "10020518",
  "10020519",
  "10020520",
  "10020521",
  "10020522",
  "10020523",
  "10020524",
  "10020525",
  "10020526",
  "10020527",
  "10020528",
  "10020529",
  "10020530",
  "10020531",
  "10020532",
  "10020533",
  "10020534",
  "10020535",
  "10020536",
];

List cashJournalList2 = [
  {"glID": "10020001", "glName": "Petty Cash HO"},
  {"glID": "10020501", "glName": "1278_Hp-cd_ Varun"},
  {"glID": "10020502", "glName": "1377_HP-CD_Pankaj"},
  {"glID": "10020503", "glName": "1344_PCash_Mill Road"},
  {"glID": "10020504", "glName": "1336_PCash_Madhurai"},
  {"glID": "10020505", "glName": "1328_PCash_Chennai"},
  {"glID": "10020506", "glName": "1310_PCash_V_One Tow"},
  {"glID": "10020507", "glName": "1299_PCash_V_Extentn"},
  {"glID": "10020508", "glName": "1294_PCash_Phursungi"},
  {"glID": "10020509", "glName": "1286_PCash_Budhwarpe"},
  {"glID": "10020510", "glName": "1385_PCash_Corporate"},
  {"glID": "10020511", "glName": "1393_PCash_Corporate"},
  {"glID": "10020512", "glName": "1369_PCash_Ahmedbad"},
  {"glID": "10020513", "glName": "0381_PCash_Mumbai"},
  {"glID": "10020514", "glName": "0365_PCash_Nelmangal"},
  {"glID": "10020515", "glName": "0357_PCash_Hyderabad"},
  {"glID": "10020516", "glName": "0822_PCash_Kolkata"},
  {"glID": "10020517", "glName": "0830_PCash_Nagpur"},
  {"glID": "10020518", "glName": "3510_PCash_Sanganur"},
  {"glID": "10020519", "glName": "3528_PCash_Jaipur"},
  {"glID": "10020520", "glName": "7882_PCas_Mysore Roa"},
  {"glID": "10020521", "glName": "7890_PCash_Vasai"},
  {"glID": "10020522", "glName": "2489_PCas_Mysore Roa"},
  {"glID": "10020523", "glName": "2505_PCash_Raipur"},
  {"glID": "10020524", "glName": "2497_PCash_Ahmedbad"},
  {"glID": "10020525", "glName": "2519_PCash_Chennai 2"},
  {"glID": "10020526", "glName": "0340_PCash_Bhopal"},
  {"glID": "10020527", "glName": "8955_PCash_Mumbai"},
  {"glID": "10020528", "glName": "9045_PCash_Kolkata"},
  {"glID": "10020529", "glName": "8997_PCash_Ranchi"},
  {"glID": "10020530", "glName": "9029_PCash_Guwahati"},
  {"glID": "10020531", "glName": "Do not Use"},
  {"glID": "10020532", "glName": "Do not use"},
  {"glID": "10020533", "glName": "8989_PCash_Corporate"},
  {"glID": "10020534", "glName": "9011_PCash_Lucknow"},
  {"glID": "10020535", "glName": "7658_PCash_Patna"},
  {"glID": "10020536", "glName": "7625_PCash_Srinagar"},
];

///New Cash Receipt Values
List cashReceiptValues = [
  {"glID": "15191101", "glName": "Cash Free- Wallet"},
  {"glID": "15191102", "glName": "Happay Master Card"},
  {"glID": "15191103", "glName": "Happay 1294 Phursung"},
  {"glID": "15191104", "glName": "Happay1299 Gollapudi"},
  {"glID": "15191105", "glName": "Happay 1310 OneTown"},
  {"glID": "15191106", "glName": "Happay 1336 Madurai"},
  {"glID": "15191107", "glName": "Happay 1344 Coimbato"},
  {"glID": "15191108", "glName": "Happay 1328 Chennai"},
  {"glID": "15191109", "glName": "Happay 0381 Mumbai"},
  {"glID": "15191110", "glName": "Happay 1278 Lalbagh"},
  {"glID": "15191111", "glName": "Happay 1377 Chickpet"},
  {"glID": "15191112", "glName": "Happay 1393 Sanjay"},
  {"glID": "15191113", "glName": "Happay 1385 Mukesh"},
  {"glID": "15191114", "glName": "Happay 1286 Budhwrpt"},
  {"glID": "15191115", "glName": "Happay 1369 Ahmdabad"},
  {"glID": "15191116", "glName": "Happay 0830 Nagpur"},
  {"glID": "15191117", "glName": "Happay 0357 Hyderbad"},
  {"glID": "15191118", "glName": "Happay 0822 Kolkata"},
  {"glID": "15191119", "glName": "Happay 3528 Jaipur"},
  {"glID": "15191120", "glName": "Happay Akas7882MysRd"},
  {"glID": "15191121", "glName": "HappayDarsh2489MysRd"},
  {"glID": "15191122", "glName": "Happay 0365 Nelmngla"},
  {"glID": "15191123", "glName": "Happay 7890 Vasai"},
  {"glID": "15191124", "glName": "Happay 2505 Raipur"},
  {"glID": "15191125", "glName": "Happay 3510 Coimbato"},
  {"glID": "15191126", "glName": "Happay 2505 Raipur"},
  {"glID": "15191127", "glName": "Happay 2497 Ahmedbad"},
  {"glID": "15191128", "glName": "Happay 2519 Chennai"},
  {"glID": "15191129", "glName": "Happay 4523 Bhopal"},
  {"glID": "15191130", "glName": "Happay 2527 Ranchi"}
];

List cashPaymentValues = [
  {'glID': '15171101', 'glName': 'Cash - Corporate'},
  {'glID': '15171102', 'glName': 'Cash - Chickpet'},
  {'glID': '15171103', 'glName': 'Cash - Mysore Road'},
  {'glID': '15171104', 'glName': 'Cash - Mysore Road'},
  {'glID': '15171105', 'glName': 'Cash - Bhudhwarpet'},
  {'glID': '15171106', 'glName': 'Cash - Phursungi'},
  {'glID': '15171107', 'glName': 'Cash - Mumbai'},
  {'glID': '15171108', 'glName': 'Cash - Madurai'},
  {'glID': '15171109', 'glName': 'Cash - Mill Road'},
  {'glID': '15171110', 'glName': 'Cash - Sanganur'},
  {'glID': '15171111', 'glName': 'Cash - Chennai'},
  {'glID': '15171112', 'glName': 'Cash - One Town'},
  {'glID': '15171113', 'glName': 'Cash - Gollapudi'},
  {'glID': '15171114', 'glName': 'Cash - Ahmedabad'},
  {'glID': '15171115', 'glName': 'Cash - Nagpur'},
  {'glID': '15171116', 'glName': 'Cash - Kolkata City'},
  {'glID': '15171117', 'glName': 'Cash - Jaipur'},
  {'glID': '15171118', 'glName': 'Cash - Raipur'},
  {'glID': '15171119', 'glName': 'Cash - Patna'},
  {'glID': '15171120', 'glName': 'Cash - Ranchi'},
  {'glID': '15171121', 'glName': 'Cash - Bhopal'},
  {'glID': '15171122', 'glName': 'Cash - Hyderabad'},
  {'glID': '15171123', 'glName': 'Cash - Vasai'},
  {'glID': '15171124', 'glName': 'Cash - Guwahati'},
  {'glID': '15171125', 'glName': 'Cash - Cuttak'},
  {'glID': '15171126', 'glName': 'Cash - Lucknow'},
  {'glID': '15171127', 'glName': 'Cash - Noida'},
  {'glID': '15171128', 'glName': 'Cash - Kolkata Ext'},
  {'glID': '15171129', 'glName': 'Cash - Srinagar'},
  {'glID': '15171130', 'glName': 'Cash - Luhari'},
  {'glID': '15171131', 'glName': 'Cash - Jalandhar'},
  {'glID': '15171132', 'glName': 'Cash - Delhi'},
  {'glID': '15171133', 'glName': 'Cash - Replacement'}
];



var companyCodeList = [
  "--Select--",
  "S001",
];
var companyCodeDE = [
  "--Select Company Code--",
  "S001",
];
var vendorCodeList = [
  "--Select--",
  "TEST002",
];

var typeOfTransactionList = [
  "--Select--",
  "Cash Receipt",
  "Cash Payment",
  // "Customer Receipt"
];
///Petty cash
List tableOne = [
  {
    "item": "",
    "amount": "",
    "GLAccount": "",
    "houseBank": "",
    "accountId": "",
    "narration": "",
    "reference": "",
    "taxCode": "",
    "CostCenter": "",
    "ProfitCenter": "",
    "assignment": "",
    "BusinessPlace": "",
    "plant": "",
    "BusinessPlaceName": "",

  },
];
///Customer Receipt
List customerTable = [
  {
    "item": "",
    "amount": "",
    "GLAccount": "",
    "houseBank": "",
    "accountId": "",
    "narration": "",
    "reference": "",
    "taxCode": "",
    "CostCenter": "",
    "ProfitCenter": "",
    "assignment": "",
    "customerName":"",
    "BusinessPlace": "",
    "plant": "",
    "BusinessPlaceName": "",

  },
];


List directExpense = [
  {
    "GLAccount":"",
    "shortText":"",
    "Dc":"",
    "amount":"",
    "taxCode":"",
    "assignment":"",
    "narration":"",
    "costCenter":"",
    "withHoldingTax":'',
    "enableTax":false
  }
];
///WithholdingTaxCodes
// List withHoldingTax = [
//   {
//     "WITHHOLDINGTAXTYPE": "1H",
//     "WITHHOLDINGTAXCODE": "IM",
//     "OFFICIALWHLDGTAXCODE": "194H"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "3H",
//     "WITHHOLDINGTAXCODE": "IN",
//     "OFFICIALWHLDGTAXCODE": "194H"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4Q",
//     "WITHHOLDINGTAXCODE": "4N",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4Q",
//     "WITHHOLDINGTAXCODE": "IW",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "5Q",
//     "WITHHOLDINGTAXCODE": "5N",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "5Q",
//     "WITHHOLDINGTAXCODE": "IX",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "A5",
//     "WITHHOLDINGTAXCODE": "IA",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "A6",
//     "WITHHOLDINGTAXCODE": "IB",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "A6",
//     "WITHHOLDINGTAXCODE": "ID",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AS",
//     "WITHHOLDINGTAXCODE": "IC",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C0",
//     "WITHHOLDINGTAXCODE": "IE",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C0",
//     "WITHHOLDINGTAXCODE": "IF",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C5",
//     "WITHHOLDINGTAXCODE": "IG",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C5",
//     "WITHHOLDINGTAXCODE": "IH",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D0",
//     "WITHHOLDINGTAXCODE": "II",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D5",
//     "WITHHOLDINGTAXCODE": "IJ",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G0",
//     "WITHHOLDINGTAXCODE": "IK",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G5",
//     "WITHHOLDINGTAXCODE": "IL",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I0",
//     "WITHHOLDINGTAXCODE": "IO",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I0",
//     "WITHHOLDINGTAXCODE": "IP",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I5",
//     "WITHHOLDINGTAXCODE": "IQ",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I5",
//     "WITHHOLDINGTAXCODE": "IR",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J0",
//     "WITHHOLDINGTAXCODE": "IS",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J0",
//     "WITHHOLDINGTAXCODE": "IT",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J5",
//     "WITHHOLDINGTAXCODE": "IU",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J5",
//     "WITHHOLDINGTAXCODE": "IV",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "K3",
//     "WITHHOLDINGTAXCODE": "K3",
//     "OFFICIALWHLDGTAXCODE": "194K"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "K4",
//     "WITHHOLDINGTAXCODE": "K4",
//     "OFFICIALWHLDGTAXCODE": "194K"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "A5",
//     "WITHHOLDINGTAXCODE": "A5",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AB",
//     "WITHHOLDINGTAXCODE": "A0",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C0",
//     "WITHHOLDINGTAXCODE": "C0",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C0",
//     "WITHHOLDINGTAXCODE": "C1",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C5",
//     "WITHHOLDINGTAXCODE": "C6",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D0",
//     "WITHHOLDINGTAXCODE": "D0",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D5",
//     "WITHHOLDINGTAXCODE": "D5",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G0",
//     "WITHHOLDINGTAXCODE": "G0",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G5",
//     "WITHHOLDINGTAXCODE": "G5",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "H1",
//     "WITHHOLDINGTAXCODE": "H1",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "H2",
//     "WITHHOLDINGTAXCODE": "H2",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I0",
//     "WITHHOLDINGTAXCODE": "I0",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I0",
//     "WITHHOLDINGTAXCODE": "I2",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I5",
//     "WITHHOLDINGTAXCODE": "I5",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I5",
//     "WITHHOLDINGTAXCODE": "I7",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "L0",
//     "WITHHOLDINGTAXCODE": "L0",
//     "OFFICIALWHLDGTAXCODE": "19LC"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "L1",
//     "WITHHOLDINGTAXCODE": "L1",
//     "OFFICIALWHLDGTAXCODE": "19LD"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "L5",
//     "WITHHOLDINGTAXCODE": "L5",
//     "OFFICIALWHLDGTAXCODE": "19LC"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "L6",
//     "WITHHOLDINGTAXCODE": "L6",
//     "OFFICIALWHLDGTAXCODE": "19LD"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "M0",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MQ",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MR",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MS",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MT",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MU",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MV",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MW",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M0",
//     "WITHHOLDINGTAXCODE": "MX",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 1,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 2,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 3,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 4,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 5,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": 6,
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": "M1",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": "MY",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M1",
//     "WITHHOLDINGTAXCODE": "MZ",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M2",
//     "WITHHOLDINGTAXCODE": "M2",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "M5",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MA",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MB",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MC",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MD",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "ME",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MF",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MG",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M5",
//     "WITHHOLDINGTAXCODE": "MH",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "M6",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MI",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MJ",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MK",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "ML",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MM",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MN",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MO",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M6",
//     "WITHHOLDINGTAXCODE": "MP",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "M7",
//     "WITHHOLDINGTAXCODE": "M7",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "SA",
//     "WITHHOLDINGTAXCODE": "SB",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "SA",
//     "WITHHOLDINGTAXCODE": "ST",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "SC",
//     "WITHHOLDINGTAXCODE": "SC",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "SC",
//     "WITHHOLDINGTAXCODE": "SO",
//     "OFFICIALWHLDGTAXCODE": 195
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 66,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 67,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 68,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 69,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 70,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 71,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 72,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 73,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "Y6",
//     "WITHHOLDINGTAXCODE": 74,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "3I",
//     "WITHHOLDINGTAXCODE": "I4",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 75,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 76,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 77,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 78,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 79,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 80,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4H",
//     "WITHHOLDINGTAXCODE": 81,
//     "OFFICIALWHLDGTAXCODE": "206C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4I",
//     "WITHHOLDINGTAXCODE": "I9",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AP",
//     "WITHHOLDINGTAXCODE": "A4",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AS",
//     "WITHHOLDINGTAXCODE": "A2",
//     "OFFICIALWHLDGTAXCODE": 194
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C7",
//     "WITHHOLDINGTAXCODE": "C4",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C7",
//     "WITHHOLDINGTAXCODE": "C7",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "CB",
//     "WITHHOLDINGTAXCODE": "C2",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "CB",
//     "WITHHOLDINGTAXCODE": "C3",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D3",
//     "WITHHOLDINGTAXCODE": "D1",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "D7",
//     "WITHHOLDINGTAXCODE": "D2",
//     "OFFICIALWHLDGTAXCODE": "194D"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G6",
//     "WITHHOLDINGTAXCODE": "G1",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "G7",
//     "WITHHOLDINGTAXCODE": "G2",
//     "OFFICIALWHLDGTAXCODE": "194G"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J7",
//     "WITHHOLDINGTAXCODE": "J6",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "JA",
//     "WITHHOLDINGTAXCODE": "J9",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AC",
//     "WITHHOLDINGTAXCODE": "A1",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C1",
//     "WITHHOLDINGTAXCODE": "C1",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4Q",
//     "WITHHOLDINGTAXCODE": "4Q",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I1",
//     "WITHHOLDINGTAXCODE": "I1",
//     "OFFICIALWHLDGTAXCODE": "19IA"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J0",
//     "WITHHOLDINGTAXCODE": "J0",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J3",
//     "WITHHOLDINGTAXCODE": "J3",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I4",
//     "WITHHOLDINGTAXCODE": "I4",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "5Q",
//     "WITHHOLDINGTAXCODE": "5Q",
//     "OFFICIALWHLDGTAXCODE": "194Q"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "A6",
//     "WITHHOLDINGTAXCODE": "A6",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C5",
//     "WITHHOLDINGTAXCODE": "C5",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I6",
//     "WITHHOLDINGTAXCODE": "I6",
//     "OFFICIALWHLDGTAXCODE": "19IA"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J4",
//     "WITHHOLDINGTAXCODE": "J4",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J5",
//     "WITHHOLDINGTAXCODE": "J5",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "3I",
//     "WITHHOLDINGTAXCODE": "I3",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AT",
//     "WITHHOLDINGTAXCODE": "A3",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J8",
//     "WITHHOLDINGTAXCODE": "J7",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "4I",
//     "WITHHOLDINGTAXCODE": "I8",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "AQ",
//     "WITHHOLDINGTAXCODE": "A7",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "J9",
//     "WITHHOLDINGTAXCODE": "J8",
//     "OFFICIALWHLDGTAXCODE": "194J"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "C6",
//     "WITHHOLDINGTAXCODE": "C6",
//     "OFFICIALWHLDGTAXCODE": "194C"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "I9",
//     "WITHHOLDINGTAXCODE": "I9",
//     "OFFICIALWHLDGTAXCODE": "194I"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "IB",
//     "WITHHOLDINGTAXCODE": "IB",
//     "OFFICIALWHLDGTAXCODE": "194A"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "1H",
//     "WITHHOLDINGTAXCODE": "H1",
//     "OFFICIALWHLDGTAXCODE": "194H"
//   },
//   {
//     "WITHHOLDINGTAXTYPE": "3H",
//     "WITHHOLDINGTAXCODE": "3H",
//     "OFFICIALWHLDGTAXCODE": "194H"
//   }
// ];

List withHoldingTax = [
    {
      "Rate": 10,
      "Tax Type": "AC",
      "Tax Code": "A1",
      "WO Tax Name": "TDS on Interest Other Than Bank 10% INV"
    },
    {
      "Rate": 10,
      "Tax Type": "A6",
      "Tax Code": "ID",
      "WO Tax Name": "TDS on Interest From Bank 10% INV"
    },
    {
      "Rate": 2,
      "Tax Type": "C0",
      "Tax Code": "C0",
      "WO Tax Name": "TDS on Contract Other than HUF & IND 2% INV"
    },
    {
      "Rate": 1,
      "Tax Type": "C1",
      "Tax Code": "C1",
      "WO Tax Name": "TDS on Contract Payment of HUF & IND 1% INV"
    },
    {
      "Rate": 2,
      "Tax Type": "1H",
      "Tax Code": "H1",
      "WO Tax Name": "TDS on Commission 2% INV"
    },
    {
      "Rate": 2,
      "Tax Type": "3I",
      "Tax Code": "I3",
      "WO Tax Name": "TDS on Rent Plant & Machinery 2% INV"
    },
    {
      "Rate": 10,
      "Tax Type": "I4",
      "Tax Code": "I4",
      "WO Tax Name": "TDS on Rent Land,Building & Furniture 10% INV"
    },
    {
      "Rate": 10,
      "Tax Type": "J0",
      "Tax Code": "J0",
      "WO Tax Name": "TDS on Professional & Consultancy 10% INV"
    },
    {
      "Rate": 2,
      "Tax Type": "J3",
      "Tax Code": "J3",
      "WO Tax Name": "TDS on Professional Technical Services 2% INV"
    },
    {
      "Rate": 2,
      "Tax Type": "J8",
      "Tax Code": "J7",
      "WO Tax Name": "TDS on Cash Withdrawal 2% INV"
    },
    {
      "Rate": 1,
      "Tax Type": "I1",
      "Tax Code": "I1",
      "WO Tax Name": "TDS On E-Commerce Operator 1% INV"
    },
    {
      "Rate": 0.1,
      "Tax Type": "4Q",
      "Tax Code": "4Q",
      "WO Tax Name": "TDS on Purchase of Goods 0.1% INV"
    },
    {
      "Rate": 10,
      "Tax Type": "AT",
      "Tax Code": "A3",
      "WO Tax Name": "TDS on Perquisite 10% INV"
    }
  ];

List tableTwo = [
  {
    "item": "",
    "amount": "",
    "GLAccount": "",
    "houseBank": "",
    "accountId": "",
    "text": "",
    "reference": "",
    "taxCode": "",
    "CostCenter": "",
    "ProfitCenter": "",
    "assignment": "",
  },
];
Map taxCode = {
  "AA": 0.000,
  "AB": 5.000,
  "AC": 12.000,
  "AD": 18.000,
  "AE": 28.000,
  "AF": 0.000,
  "AG": 2.500,
  "AH": 6.000,
  "AI": 9.000,
  "AJ": 14.000,
  "E0": 0.000,
  "E1": 18.000,
  "E2": 18.000,
  "E3": 18.000,
  "F0": 0.000,
  "F1": 0.000,
  "F2": 0.000,
  "F3": 18.000,
  "F4": 9.000,
  "F5": 9.000,
  "F6": 18.000,
  "F7": 9.000,
  "F8": 9.000,
  "G0": 0.000,
  "G1": 0.000,
  "G2": 0.000,
  "G3": 18.000,
  "G4": 9.000,
  "G5": 9.000,
  "G6": 18.000,
  "G7": 9.000,
  "G8": 9.000,
  "GA": 0.000,
  "GB": 5.000,
  "GC": 12.000,
  "GD": 18.000,
  "GE": 28.000,
  "GF": 0.000,
  "GG": 2.500,
  "GH": 6.000,
  "GI": 9.000,
  "GJ": 14.000,
  "H1": 18.000,
  "H2": 9.000,
  "H3": 9.000,
  "H4": 18.000,
  "H5": 9.000,
  "H6": 9.000,
  "IS": 0.000,
  "J1": 18.000,
  "J2": 9.000,
  "J3": 9.000,
  "J4": 18.000,
  "J5": 9.000,
  "J6": 9.000,
  "JG": 0.075,
  "JH": 1.000,
  "JI": 9.000,
  "JJ": 18.000,
  "JK": 9.000,
  "JL": 18.000,
  "JM": 9.000,
  "JN": 9.000,
  "JO": 9.000,
  "JP": 9.000,
  "JQ": 18.000,
  "JR": 18.000,
  "JS": 9.000,
  "JT": 9.000,
  "K1": 18.000,
  "K2": 18.000,
  "K3": 18.000,
  "K4": 18.000,
  "K9": 18.000,
  "L1": 18.000,
  "NT": 0.000,
  "RN": 18.000,
  "RS": 18.000,
};

// List taxCodesDELine =  [
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GA",
//     "TAXCODENAME": "IP IGST@0%",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GB",
//     "TAXCODENAME": "IP IGST@5%",
//     "TAXPER": " 5.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GC",
//     "TAXCODENAME": "IP IGST@12%",
//     "TAXPER": " 12.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GD",
//     "TAXCODENAME": "IP IGST@18%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GE",
//     "TAXCODENAME": "IP IGST@28%",
//     "TAXPER": " 28.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GF",
//     "TAXCODENAME": "IP CGST @0% % & SGST @0%",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GG",
//     "TAXCODENAME": "IP CGST @2.5% & SGST @2.5%",
//     "TAXPER": " 2.500,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GH",
//     "TAXCODENAME": "IP CGST@6%& SGST@6%",
//     "TAXPER": " 6.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GI",
//     "TAXCODENAME": "IP CGST@9% & SGST@9%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AA",
//     "TAXCODENAME": "OP IGST@0%",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AB",
//     "TAXCODENAME": "OP IGST@5%",
//     "TAXPER": " 5.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AC",
//     "TAXCODENAME": "OP IGST@12%",
//     "TAXPER": " 12.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AD",
//     "TAXCODENAME": "OP IGST@18%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AE",
//     "TAXCODENAME": "OP IGST@28%",
//     "TAXPER": " 28.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AF",
//     "TAXCODENAME": "OP CGST@0% &SGST@0%",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AG",
//     "TAXCODENAME": "OP CGST@2.5% &SGST@2.5%",
//     "TAXPER": " 2.500,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AH",
//     "TAXCODENAME": "OP CGST@6% &SGST@6%",
//     "TAXPER": " 6.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AI",
//     "TAXCODENAME": "OP CGST@9% &SGST@9%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "AJ",
//     "TAXCODENAME": "OP CGST@14% &SGST@14%",
//     "TAXPER": " 14.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "E0",
//     "TAXCODENAME": "IGST exports without duty",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "E1",
//     "TAXCODENAME": "IGST 18% exports with duty",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "E2",
//     "TAXCODENAME": "IGST 18% SEZ sale",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "E3",
//     "TAXCODENAME": "IGST 18% EOU sale",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F0",
//     "TAXCODENAME": "Exempted outputÂ  IGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F1",
//     "TAXCODENAME": "Exempted outputÂ  CGST + SGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F2",
//     "TAXCODENAME": "Exempted outputÂ  CGST+ UTGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F3",
//     "TAXCODENAME": "IGST 18% - Domestic output GST",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F4",
//     "TAXCODENAME": "CGST 9% +SGST 9% - Domestic output GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F5",
//     "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic output GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F6",
//     "TAXCODENAME": "IGST 18% + Comp CESS 18%- Domestic output GST",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F7",
//     "TAXCODENAME": "CGST 9% +SGST 9% + Comp CESS 18%- Dmstc output GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "F8",
//     "TAXCODENAME": "CGST 9% +UTGST 9% + Comp CESS 18%-Dmstc output GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G0",
//     "TAXCODENAME": "Exempted inputÂ  IGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G1",
//     "TAXCODENAME": "Exempted inputÂ  CGST + SGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G2",
//     "TAXCODENAME": "Exempted inputÂ  CGST+ UTGST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G3",
//     "TAXCODENAME": "IGST 18% - Domestic input GST",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G4",
//     "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G5",
//     "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G6",
//     "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G7",
//     "TAXCODENAME": "CGST 9% +SGST 9% + Comp CESS 18%-Dmstc input GST",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "G8",
//     "TAXCODENAME": "CGST 9% +UTGST 9% + Comp CESS 18%-Dmstc input GST",
//     "TAXPER": " 9.000,"
//   },
//
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "GJ",
//     "TAXCODENAME": "IP CGST@14%& SGST@14%",
//     "TAXPER": " 14.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H1",
//     "TAXCODENAME": "IGST 18% - Domestic input GST - ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H2",
//     "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST- ND",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H3",
//     "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST- ND",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H4",
//     "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST- ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H5",
//     "TAXCODENAME": "CGST 9% +SGST 9% + CompCESS18%-Dmstc input GST- ND",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "H6",
//     "TAXCODENAME": "CGST9%+UTGST9% + CompCESS18%-Dmstc input GST- ND",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "IS",
//     "TAXCODENAME": "Dummy tax code - Input tax",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J1",
//     "TAXCODENAME": "IGST 18% - Domestic input GST -RCM",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J2",
//     "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST-RCM",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J3",
//     "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST-RCM",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J4",
//     "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST- RCM",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J5",
//     "TAXCODENAME": "CGST 9% +SGST 9% + CompCESS 18%-Dmstc inputGST-RCM",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "J6",
//     "TAXCODENAME": "CGST 9%+UTGST9% +CompCESS 18% -Dmstc input GST-RCM",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JG",
//     "TAXCODENAME": "Final PAN TCS 0.075%",
//     "TAXPER": " 0.075,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JH",
//     "TAXCODENAME": "Final NoPAN TCS 1%",
//     "TAXPER": " 1.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JI",
//     "TAXCODENAME": "Interim PAN-CGST+SGST+ TCS 0.075%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JJ",
//     "TAXCODENAME": "Interim PAN- IGST +TCS 0.075%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JK",
//     "TAXCODENAME": "Interim PAN-CGST+SGST+ CESS+TCS 0.075%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JL",
//     "TAXCODENAME": "Interim PAN- IGST +CESS+TCS 0.075%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JM",
//     "TAXCODENAME": "Interim PAN CGST+UTGST+TCS 0.075%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JN",
//     "TAXCODENAME": "Interim PAN CGST+UTGST+CESS+TCS 0.075%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JO",
//     "TAXCODENAME": "Interim NoPAN-CGST+SGST + TCS 1%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JP",
//     "TAXCODENAME": "Interim NoPAN-CGST+SGST+ CESS+TCS 1%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JQ",
//     "TAXCODENAME": "Interim NoPAN- IGST+TCS 1%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JR",
//     "TAXCODENAME": "Interim NoPAN- IGST +CESS+TCS 1%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JS",
//     "TAXCODENAME": "Interim NoPAN CGST+UTGST+TCS 1%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "JT",
//     "TAXCODENAME": "Interim NoPAN CGST+UTGST+CESS+TCS 1%",
//     "TAXPER": " 9.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "K1",
//     "TAXCODENAME": "IGST 18% - Imports",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "K2",
//     "TAXCODENAME": "IGST 18% - Imports + Comp CESS 18%",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "K3",
//     "TAXCODENAME": "IGST 18% - Imports - ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "K4",
//     "TAXCODENAME": "IGST 18% - Imports + Comp CESS 18% - ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "K9",
//     "TAXCODENAME": "IGST 18% - Imports - SEZ purchase",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "L1",
//     "TAXCODENAME": "IGST 18% - Imports - SEZ purchase - ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "NT",
//     "TAXCODENAME": "Zero rated Non GST",
//     "TAXPER": " 0.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "RN",
//     "TAXCODENAME": "IGST 18% -Import of Services -RCM -ND",
//     "TAXPER": " 18.000,"
//   },
//   {
//     "TAXCALCULATIONPROCEDURE": "0TXIN",
//     "TAXCODE": "RS",
//     "TAXCODENAME": "IGST 18% -Import of Services -RCM",
//     "TAXPER": " 18.000,"
//   }
// ];

List taxCodesDELine =  [
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "--Select--",
    "TAXCODENAME": "",
    "TAXPER": 0
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GA",
    "TAXCODENAME": "IP IGST@0%",
    "TAXPER": 0
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GB",
    "TAXCODENAME": "IP IGST@5%",
    "TAXPER": 5
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GC",
    "TAXCODENAME": "IP IGST@12%",
    "TAXPER": 12
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GD",
    "TAXCODENAME": "IP IGST@18%",
    "TAXPER": 18
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GE",
    "TAXCODENAME": "IP IGST@28%",
    "TAXPER": 28
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GF",
    "TAXCODENAME": "IP CGST @0% % & SGST @0%",
    "TAXPER": 0
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GG",
    "TAXCODENAME": "IP CGST @2.5% & SGST @2.5%",
    "TAXPER": 2.5
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GH",
    "TAXCODENAME": "IP CGST@6%& SGST@6%",
    "TAXPER": 6
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GI",
    "TAXCODENAME": "IP CGST@9% & SGST@9%",
    "TAXPER": 9
  },
  {
    "TAXCALCULATIONPROCEDURE": "0TXIN",
    "TAXCODE": "GJ",
    "TAXCODENAME": "IP CGST@14%& SGST@14%",
    "TAXPER": 14
  },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AA",
      "TAXCODENAME": "OP IGST@0%",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AB",
      "TAXCODENAME": "OP IGST@5%",
      "TAXPER": 5
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AC",
      "TAXCODENAME": "OP IGST@12%",
      "TAXPER": 12
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AD",
      "TAXCODENAME": "OP IGST@18%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AE",
      "TAXCODENAME": "OP IGST@28%",
      "TAXPER": 28
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AF",
      "TAXCODENAME": "OP CGST@0% &SGST@0%",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AG",
      "TAXCODENAME": "OP CGST@2.5% &SGST@2.5%",
      "TAXPER": 2.5
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AH",
      "TAXCODENAME": "OP CGST@6% &SGST@6%",
      "TAXPER": 6
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AI",
      "TAXCODENAME": "OP CGST@9% &SGST@9%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "AJ",
      "TAXCODENAME": "OP CGST@14% &SGST@14%",
      "TAXPER": 14
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "E0",
      "TAXCODENAME": "IGST exports without duty",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "E1",
      "TAXCODENAME": "IGST 18% exports with duty",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "E2",
      "TAXCODENAME": "IGST 18% SEZ sale",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "E3",
      "TAXCODENAME": "IGST 18% EOU sale",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F0",
      "TAXCODENAME": "Exempted outputÂ  IGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F1",
      "TAXCODENAME": "Exempted outputÂ  CGST + SGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F2",
      "TAXCODENAME": "Exempted outputÂ  CGST+ UTGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F3",
      "TAXCODENAME": "IGST 18% - Domestic output GST",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F4",
      "TAXCODENAME": "CGST 9% +SGST 9% - Domestic output GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F5",
      "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic output GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F6",
      "TAXCODENAME": "IGST 18% + Comp CESS 18%- Domestic output GST",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F7",
      "TAXCODENAME": "CGST 9% +SGST 9% + Comp CESS 18%- Dmstc output GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "F8",
      "TAXCODENAME": "CGST 9% +UTGST 9% + Comp CESS 18%-Dmstc output GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G0",
      "TAXCODENAME": "Exempted inputÂ  IGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G1",
      "TAXCODENAME": "Exempted inputÂ  CGST + SGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G2",
      "TAXCODENAME": "Exempted inputÂ  CGST+ UTGST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G3",
      "TAXCODENAME": "IGST 18% - Domestic input GST",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G4",
      "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G5",
      "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G6",
      "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G7",
      "TAXCODENAME": "CGST 9% +SGST 9% + Comp CESS 18%-Dmstc input GST",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "G8",
      "TAXCODENAME": "CGST 9% +UTGST 9% + Comp CESS 18%-Dmstc input GST",
      "TAXPER": 9
    },

    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H1",
      "TAXCODENAME": "IGST 18% - Domestic input GST - ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H2",
      "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST- ND",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H3",
      "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST- ND",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H4",
      "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST- ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H5",
      "TAXCODENAME": "CGST 9% +SGST 9% + CompCESS18%-Dmstc input GST- ND",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "H6",
      "TAXCODENAME": "CGST9%+UTGST9% + CompCESS18%-Dmstc input GST- ND",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "IS",
      "TAXCODENAME": "Dummy tax code - Input tax",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J1",
      "TAXCODENAME": "IGST 18% - Domestic input GST -RCM",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J2",
      "TAXCODENAME": "CGST 9% +SGST 9% - Domestic input GST-RCM",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J3",
      "TAXCODENAME": "CGST 9% +UTGST 9% - Domestic input GST-RCM",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J4",
      "TAXCODENAME": "IGST 18% + Comp CESS 18% - Domestic input GST- RCM",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J5",
      "TAXCODENAME": "CGST 9% +SGST 9% + CompCESS 18%-Dmstc inputGST-RCM",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "J6",
      "TAXCODENAME": "CGST 9%+UTGST9% +CompCESS 18% -Dmstc input GST-RCM",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JG",
      "TAXCODENAME": "Final PAN TCS 0.075%",
      "TAXPER": 0.075
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JH",
      "TAXCODENAME": "Final NoPAN TCS 1%",
      "TAXPER": 1
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JI",
      "TAXCODENAME": "Interim PAN-CGST+SGST+ TCS 0.075%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JJ",
      "TAXCODENAME": "Interim PAN- IGST +TCS 0.075%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JK",
      "TAXCODENAME": "Interim PAN-CGST+SGST+ CESS+TCS 0.075%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JL",
      "TAXCODENAME": "Interim PAN- IGST +CESS+TCS 0.075%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JM",
      "TAXCODENAME": "Interim PAN CGST+UTGST+TCS 0.075%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JN",
      "TAXCODENAME": "Interim PAN CGST+UTGST+CESS+TCS 0.075%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JO",
      "TAXCODENAME": "Interim NoPAN-CGST+SGST + TCS 1%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JP",
      "TAXCODENAME": "Interim NoPAN-CGST+SGST+ CESS+TCS 1%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JQ",
      "TAXCODENAME": "Interim NoPAN- IGST+TCS 1%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JR",
      "TAXCODENAME": "Interim NoPAN- IGST +CESS+TCS 1%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JS",
      "TAXCODENAME": "Interim NoPAN CGST+UTGST+TCS 1%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "JT",
      "TAXCODENAME": "Interim NoPAN CGST+UTGST+CESS+TCS 1%",
      "TAXPER": 9
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "K1",
      "TAXCODENAME": "IGST 18% - Imports",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "K2",
      "TAXCODENAME": "IGST 18% - Imports + Comp CESS 18%",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "K3",
      "TAXCODENAME": "IGST 18% - Imports - ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "K4",
      "TAXCODENAME": "IGST 18% - Imports + Comp CESS 18% - ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "K9",
      "TAXCODENAME": "IGST 18% - Imports - SEZ purchase",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "L1",
      "TAXCODENAME": "IGST 18% - Imports - SEZ purchase - ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "NT",
      "TAXCODENAME": "Zero rated Non GST",
      "TAXPER": 0
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "RN",
      "TAXCODENAME": "IGST 18% -Import of Services -RCM -ND",
      "TAXPER": 18
    },
    {
      "TAXCALCULATIONPROCEDURE": "0TXIN",
      "TAXCODE": "RS",
      "TAXCODENAME": "IGST 18% -Import of Services -RCM",
      "TAXPER": 18
    }
  ];







